#!/usr/bin/env bash
# =============================================================================
# setup_lsp.sh
# Automates clangd LSP configuration for C/C++ projects (native + Emscripten).
# Run from the project root.
#
# Usage:
#   ./setup_lsp.sh [--dry-run] [--force] [--std <standard>] [--help]
#
# Options:
#   --dry-run        Print generated files to stdout without writing anything.
#   --force          Overwrite existing .clangd without prompting.
#   --std <std>      C/C++ standard to use (default: c11 or c++17).
#   --help           Show this message and exit.
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
# Constants
# -----------------------------------------------------------------------------

readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly CLANGD_FILE=".clangd"
readonly CLANGD_BACKUP=".clangd.bak"
readonly GITIGNORE_FILE=".gitignore"
readonly TEMPLATES_DIR="templates"
readonly POST_CLONE_SCRIPT="post-clone.sh"

# -----------------------------------------------------------------------------
# Defaults (overridable via flags)
# -----------------------------------------------------------------------------

DRY_RUN=false
FORCE=false
STD_OVERRIDE=""

# -----------------------------------------------------------------------------
# Logging
# -----------------------------------------------------------------------------

log()  { printf '[%s] %s\n' "$(date +%H:%M:%S)" "$*"; }
info() { log "INFO  $*"; }
warn() { log "WARN  $*" >&2; }
die()  { log "ERROR $*" >&2; exit 1; }

# -----------------------------------------------------------------------------
# Argument parsing
# -----------------------------------------------------------------------------

usage() {
    grep '^#' "$0" | grep -v '#!/' | sed 's/^# \{0,1\}//'
    exit 0
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run) DRY_RUN=true ;;
        --force)   FORCE=true ;;
        --std)     [[ -n "${2-}" ]] || die "--std requires an argument."; STD_OVERRIDE="$2"; shift ;;
        --help|-h) usage ;;
        *) die "Unknown option: $1. Use --help for usage." ;;
    esac
    shift
done

# -----------------------------------------------------------------------------
# Platform check
# -----------------------------------------------------------------------------

OS="$(uname -s)"
[[ "$OS" == "Darwin" || "$OS" == "Linux" ]] \
    || die "Unsupported OS: $OS. Only Darwin and Linux are supported."

# -----------------------------------------------------------------------------
# Dry-run write helper
# Writes to file or prints to stdout depending on DRY_RUN flag.
# Usage: write_file <path> <content>
# -----------------------------------------------------------------------------

write_file() {
    local path="$1"
    local content="$2"

    if [[ "$DRY_RUN" == true ]]; then
        printf '\n--- DRY RUN: %s ---\n%s\n' "$path" "$content"
    else
        printf '%s\n' "$content" > "$path"
    fi
}

append_file() {
    local path="$1"
    local content="$2"

    if [[ "$DRY_RUN" == true ]]; then
        printf '%s\n' "$content"
    else
        printf '%s\n' "$content" >> "$path"
    fi
}

# -----------------------------------------------------------------------------
# macOS SDK detection
# -----------------------------------------------------------------------------

get_sdk_path() {
    if [[ "$OS" == "Darwin" ]]; then
        xcrun --show-sdk-path 2>/dev/null \
            || echo "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
    fi
}

# -----------------------------------------------------------------------------
# Emscripten detection
# Searches build.sh, CMakeLists.txt, and Makefile for emcc/em++ invocations.
# -----------------------------------------------------------------------------

detect_emscripten() {
    local candidates=(build.sh CMakeLists.txt Makefile)
    local f

    for f in "${candidates[@]}"; do
        [[ -f "$f" ]] && grep -qE 'emcc|em\+\+' "$f" && return 0
    done
    return 1
}

# -----------------------------------------------------------------------------
# Language standard resolution
# Detects C vs C++ from source files and returns an appropriate default.
# -----------------------------------------------------------------------------

resolve_std() {
    if [[ -n "$STD_OVERRIDE" ]]; then
        printf '%s' "$STD_OVERRIDE"
        return
    fi

    # Detect source language from files present in common source locations
    if find . \( -name "*.cpp" -o -name "*.cc" -o -name "*.cxx" \) \
            -not -path "./.git/*" -quit 2>/dev/null | grep -q .; then
        printf 'c++17'
    else
        printf 'c11'
    fi
}

# -----------------------------------------------------------------------------
# Emscripten system include paths
# Runs emcc in preprocessor mode to extract the include search path.
# -----------------------------------------------------------------------------

get_emscripten_includes() {
    command -v emcc >/dev/null 2>&1 \
        || die "emcc not found in PATH. Source emsdk_env.sh before running."

    emcc -xc -E -v - < /dev/null 2>&1 \
        | awk '/^#include <\.\.\.> search starts here:/{found=1; next}
               /^End of search list\./{found=0}
               found && /^ /{sub(/^ +/, ""); print}'
}

# -----------------------------------------------------------------------------
# .clangd generation
# Builds the full YAML in a variable; writes once to avoid partial files.
# -----------------------------------------------------------------------------

generate_clangd() {
    local is_emscripten="$1"
    local sdk_path="$2"
    local std="$3"

    # Common flags shared by both modes
    local -a add_flags=(
        '"-Iinclude"'
        '"-Isrc"'
        '"-Wall"'
        '"-Wextra"'
        '"-Wshadow"'
        '"-Wconversion"'
        "\"-std=${std}\""
    )

    local -a remove_flags
    local extra_block=""

    if [[ "$is_emscripten" == true ]]; then
        add_flags+=(
            '"-DEMSCRIPTEN"'
            '"--target=wasm32-unknown-emscripten"'
        )

        # Collect Emscripten system includes
        local em_includes
        em_includes="$(get_emscripten_includes)"

        if [[ -z "$em_includes" ]]; then
            warn "No Emscripten include paths detected. .clangd may be incomplete."
        else
            while IFS= read -r inc_path; do
                [[ -n "$inc_path" ]] && add_flags+=("\"-isystem\", \"${inc_path}\"")
            done <<< "$em_includes"
        fi

        remove_flags=(
            '"-isysroot*"'
            '"-mllvm"'
            '"--sysroot=*"'
            '"--target=*"'
        )
    else
        # Native mode: only add sysroot on macOS
        if [[ "$OS" == "Darwin" && -n "$sdk_path" ]]; then
            add_flags+=("\"-isysroot\", \"${sdk_path}\"")
        fi

        remove_flags=(
            '"-mllvm"'
            '"--sysroot=*"'
            '"--target=*"'
        )
    fi

    # Build Add array lines
    local add_lines=""
    local flag
    for flag in "${add_flags[@]}"; do
        add_lines+="    ${flag},"$'\n'
    done
    add_lines="${add_lines%,$'\n'}"  # strip trailing comma from last entry

    # Build Remove array lines
    local remove_lines=""
    for flag in "${remove_flags[@]}"; do
        remove_lines+="    ${flag},"$'\n'
    done
    remove_lines="${remove_lines%,$'\n'}"

    # Assemble full YAML
    printf '%s' "\
CompileFlags:
  Add:
${add_lines}
  Remove:
${remove_lines}

Diagnostics:
  UnusedIncludes: Strict
  MissingIncludes: Strict

Index:
  Background: Build

InlayHints:
  Enabled: Yes
  ParameterNames: Yes
  DeducedTypes: Yes
"
}

# -----------------------------------------------------------------------------
# .clangd.fallback (minimal, portable)
# -----------------------------------------------------------------------------

generate_clangd_fallback() {
    printf '%s' "\
# Minimal fallback .clangd - regenerate with setup_lsp.sh
CompileFlags:
  Remove:
    \"-mllvm\",
    \"--sysroot=*\",
    \"--target=*\"

Index:
  Background: Build
"
}

# -----------------------------------------------------------------------------
# post-clone.sh generation
# -----------------------------------------------------------------------------

generate_post_clone() {
    printf '%s' "\
#!/usr/bin/env bash
# post-clone.sh - Reconfigures LSP after cloning this repository.
# Run once from the project root.
set -euo pipefail

SCRIPT_DIR=\"\$(cd \"\$(dirname \"\$0\")\" && pwd)\"

for candidate in \
    \"\${SCRIPT_DIR}/setup_lsp.sh\" \
    \"\${SCRIPT_DIR}/templates/setup_lsp.sh\"; do
    if [[ -x \"\$candidate\" ]]; then
        exec \"\$candidate\" \"\$@\"
    fi
done

echo 'ERROR: setup_lsp.sh not found.' >&2
exit 1
"
}

# -----------------------------------------------------------------------------
# .gitignore update
# Appends .clangd entry only if not already present.
# -----------------------------------------------------------------------------

update_gitignore() {
    if [[ "$DRY_RUN" == true ]]; then
        info "DRY RUN: would add .clangd to ${GITIGNORE_FILE} (if missing)."
        return
    fi

    if [[ -f "$GITIGNORE_FILE" ]]; then
        if grep -qE '^\.clangd$' "$GITIGNORE_FILE"; then
            info ".gitignore already contains .clangd — skipping."
            return
        fi
        printf '\n# clangd configuration (machine-specific, generated by setup_lsp.sh)\n.clangd\n' \
            >> "$GITIGNORE_FILE"
    else
        printf '# clangd configuration (machine-specific, generated by setup_lsp.sh)\n.clangd\n' \
            > "$GITIGNORE_FILE"
    fi

    info "Updated ${GITIGNORE_FILE}."
}

# -----------------------------------------------------------------------------
# YAML validation (requires python3, non-fatal if unavailable)
# -----------------------------------------------------------------------------

validate_yaml() {
    local path="$1"

    if command -v python3 >/dev/null 2>&1; then
        python3 -c "import sys, yaml; yaml.safe_load(open(sys.argv[1]))" "$path" 2>/dev/null \
            && info "YAML validation passed: ${path}" \
            || warn "YAML validation failed: ${path}. Check the file manually."
    else
        info "python3 not found — skipping YAML validation."
    fi
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------

main() {
    info "Starting clangd LSP setup (OS: ${OS}, dry-run: ${DRY_RUN})."

    # --- Resolve configuration inputs ---
    local sdk_path=""
    sdk_path="$(get_sdk_path)"

    local is_emscripten=false
    detect_emscripten && is_emscripten=true

    local std
    std="$(resolve_std)"

    info "Mode       : $( [[ "$is_emscripten" == true ]] && echo "Emscripten/WASM" || echo "Native (${OS})" )"
    info "Standard   : ${std}"
    [[ -n "$sdk_path" ]] && info "SDK path   : ${sdk_path}"

    # --- Backup existing .clangd ---
    if [[ "$DRY_RUN" == false && -f "$CLANGD_FILE" ]]; then
        if [[ "$FORCE" == false ]]; then
            warn "${CLANGD_FILE} already exists. Backing up to ${CLANGD_BACKUP}."
            cp "$CLANGD_FILE" "$CLANGD_BACKUP"
        fi
    fi

    # --- Generate and write .clangd ---
    local clangd_content
    clangd_content="$(generate_clangd "$is_emscripten" "$sdk_path" "$std")"
    write_file "$CLANGD_FILE" "$clangd_content"
    info "Written: ${CLANGD_FILE}"

    # --- Validate generated YAML ---
    [[ "$DRY_RUN" == false ]] && validate_yaml "$CLANGD_FILE"

    # --- Create templates/ directory with fallback ---
    if [[ "$DRY_RUN" == false && ! -d "$TEMPLATES_DIR" ]]; then
        mkdir -p "$TEMPLATES_DIR"
        generate_clangd_fallback > "${TEMPLATES_DIR}/.clangd.fallback"

        # Copy this script into templates/ so post-clone.sh can find it
        cp "${SCRIPT_DIR}/${SCRIPT_NAME}" "${TEMPLATES_DIR}/setup_lsp.sh"
        chmod +x "${TEMPLATES_DIR}/setup_lsp.sh"

        info "Created ${TEMPLATES_DIR}/ with .clangd.fallback and setup_lsp.sh."
    fi

    # --- Update .gitignore ---
    update_gitignore

    # --- Generate post-clone.sh ---
    local post_clone_content
    post_clone_content="$(generate_post_clone)"
    write_file "$POST_CLONE_SCRIPT" "$post_clone_content"

    if [[ "$DRY_RUN" == false ]]; then
        chmod +x "$POST_CLONE_SCRIPT"
        info "Written: ${POST_CLONE_SCRIPT}"
    fi

    # --- Ensure this script is executable ---
    [[ "$DRY_RUN" == false ]] && chmod +x "${SCRIPT_DIR}/${SCRIPT_NAME}"

    info "Setup complete."
    printf '\nNext steps:\n'
    printf '  1. Build the project (./build.sh, cmake, make, etc.)\n'
    printf '  2. Open the project in your editor — clangd will pick up .clangd automatically.\n'
    printf '  3. For new clones: run ./post-clone.sh to regenerate .clangd.\n'
    printf '\nTo bootstrap a new project:\n'
    printf '  cp -r %s/ new-project/ && cd new-project && ./post-clone.sh\n' "$TEMPLATES_DIR"
}

main "$@"
