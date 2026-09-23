#!/usr/bin/env bash

set -euo pipefail

# ==============================================================================
# Dotfiles Installer
# ==============================================================================

readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="${SCRIPT_DIR}/setup.log"

readonly NVIM_CONFIG_REPO="https://github.com/fibonatto/nvim-config.git"

# ==============================================================================
# Colors
# ==============================================================================

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly BOLD='\033[1m'
readonly NC='\033[0m'

# ==============================================================================
# OS Detection
# ==============================================================================

if [[ "$OSTYPE" == "darwin"* ]]; then
    readonly OS_TYPE="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    readonly OS_TYPE="linux"
else
    readonly OS_TYPE="unknown"
fi

# ==============================================================================
# Paths
# ==============================================================================

readonly ZSHRC="$HOME/.zshrc"
readonly ZSH_PLUGINS="$HOME/.zsh_plugins.txt"

readonly TMUX_CONFIG="$HOME/.tmux.conf"

readonly KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"

readonly NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

readonly BACKUP_SUFFIX=".$(date +%Y%m%d%H%M%S).backup"

# ==============================================================================
# Logging
# ==============================================================================

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $*" | tee -a "$LOG_FILE"
}

# ==============================================================================
# Output
# ==============================================================================

print_header() {
    echo
    echo -e "${BLUE}${BOLD}================================${NC}"
    echo -e "${BLUE}${BOLD}$1${NC}"
    echo -e "${BLUE}${BOLD}================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
    log "SUCCESS: $1"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
    log "WARNING: $1"
}

print_error() {
    echo -e "${RED}✗ $1${NC}" >&2
    log "ERROR: $1"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
    log "INFO: $1"
}

# ==============================================================================
# Utilities
# ==============================================================================

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

backup_path() {
    local path="$1"

    if [[ -e "$path" || -L "$path" ]]; then
        local backup="${path}${BACKUP_SUFFIX}"

        mv "$path" "$backup"

        print_success "Backed up $path -> $backup"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"

    if [[ ! -e "$source" ]]; then
        print_warning "Source does not exist: $source"
        return 1
    fi

    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" ]]; then
        rm "$target"
    elif [[ -e "$target" ]]; then
        backup_path "$target"
    fi

    ln -s "$source" "$target"

    print_success "Linked $target -> $source"
}

# ==============================================================================
# Homebrew
# ==============================================================================

check_homebrew() {
    if [[ "$OS_TYPE" != "macos" ]]; then
        return 0
    fi

    print_header "Checking Homebrew"

    if command_exists brew; then
        print_success "Homebrew is installed"
    else
        print_error "Homebrew is not installed"
        print_info "Install it from https://brew.sh"
        return 1
    fi
}

# ==============================================================================
# Antidote
# ==============================================================================


check_antidote() {
    local antidote_script

    if command_exists brew; then
        antidote_script="$(brew --prefix antidote)/share/antidote/antidote.zsh"
    else
        print_error "Homebrew is not installed"
        return 1
    fi

    if [[ -f "$antidote_script" ]]; then
        print_success "antidote"
        return 0
    fi

    print_error "antidote is not installed"
    return 1
}

# ==============================================================================
# Dependencies
# ==============================================================================

check_dependencies() {
    print_header "Checking Dependencies"

    local missing=()

    local dependencies=(
        git
        curl
        zsh
        nvim
        tmux
        eza
        rg
        kitty
    )

    for dependency in "${dependencies[@]}"; do
        if command_exists "$dependency"; then
            print_success "$dependency"
        else
            missing+=("$dependency")
            print_error "$dependency is not installed"
        fi
    done

		if ! check_antidote; then
        missing+=("antidote")
    fi

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo

        print_error "Missing dependencies: ${missing[*]}"

        if [[ "$OS_TYPE" == "macos" ]]; then
            print_info "Install missing packages with Homebrew:"
            echo
            echo "  brew install ${missing[*]}"
        fi

        return 1
    fi
}

# ==============================================================================
# Zsh
# ==============================================================================

configure_zsh() {
    print_header "Configuring Zsh"

    if [[ -f "$SCRIPT_DIR/.zshrc" ]]; then
        create_symlink "$SCRIPT_DIR/.zshrc" "$ZSHRC"
    else
        print_warning "No .zshrc found in $SCRIPT_DIR"
    fi

    if [[ -f "$SCRIPT_DIR/zsh_plugins.txt" ]]; then
        create_symlink "$SCRIPT_DIR/zsh_plugins.txt" "$ZSH_PLUGINS"
    else
        print_warning "No zsh_plugins.txt found in $SCRIPT_DIR"
    fi

    if [[ "$SHELL" != *"zsh"* ]]; then
        print_warning "Current login shell is $SHELL"
        print_info "Change it with: chsh -s \"$(command -v zsh)\""
    else
        print_success "Zsh is the current shell"
    fi
}

# ==============================================================================
# Terminal Tools
# ==============================================================================

configure_terminal_tools() {
    print_header "Configuring Terminal Tools"

    # tmux
    if [[ -f "$SCRIPT_DIR/tmux.conf" ]]; then
        create_symlink "$SCRIPT_DIR/tmux.conf" "$TMUX_CONFIG"
    else
        print_warning "No tmux.conf found"
    fi

    # Kitty
    if [[ -f "$SCRIPT_DIR/kitty.conf" ]]; then
        create_symlink "$SCRIPT_DIR/kitty.conf" "$KITTY_CONFIG"
    else
        print_warning "No kitty.conf found"
    fi
}

# ==============================================================================
# Neovim
# ==============================================================================

install_nvim_config() {
    print_header "Configuring Neovim"

    local nvim_parent
    nvim_parent="$(dirname "$NVIM_CONFIG")"

    mkdir -p "$nvim_parent"

    if [[ -L "$NVIM_CONFIG" ]]; then
        print_info "Existing Neovim configuration is a symlink"

        if [[ "$(readlink "$NVIM_CONFIG")" == "$NVIM_CONFIG_REPO" ]]; then
            print_success "Neovim configuration already configured"
            return 0
        fi

        backup_path "$NVIM_CONFIG"
    fi

    if [[ -d "$NVIM_CONFIG" ]]; then
        if [[ -d "$NVIM_CONFIG/.git" ]]; then
            local remote
            remote="$(git -C "$NVIM_CONFIG" remote get-url origin 2>/dev/null || true)"

            if [[ "$remote" == "$NVIM_CONFIG_REPO" ]]; then
                print_success "Neovim configuration already cloned"
                return 0
            fi
        fi

        backup_path "$NVIM_CONFIG"
    fi

    print_info "Cloning Neovim configuration..."

    git clone "$NVIM_CONFIG_REPO" "$NVIM_CONFIG"

    print_success "Neovim configuration installed"
    print_info "Lazy.nvim will install plugins on the first nvim launch"
}

# ==============================================================================
# Neovim Environment
# ==============================================================================

check_nvim_environment() {
    print_header "Checking Neovim Environment"

    local optional=(
        clangd
        node
        npm
        typescript-language-server
    )

    for dependency in "${optional[@]}"; do
        if command_exists "$dependency"; then
            print_success "$dependency"
        else
            print_warning "$dependency is not installed"
        fi
    done
}

# ==============================================================================
# Backup
# ==============================================================================

backup_configurations() {
    print_header "Backing Up Existing Configurations"

    local configs=(
        "$ZSHRC"
        "$ZSH_PLUGINS"
        "$TMUX_CONFIG"
        "$KITTY_CONFIG"
        "$NVIM_CONFIG"
    )

    for config in "${configs[@]}"; do
        if [[ -e "$config" || -L "$config" ]]; then
            backup_path "$config"
        fi
    done
}

# ==============================================================================
# Health Check
# ==============================================================================

health_check() {
    print_header "Health Check"

    local issues=0

    # --------------------------------------------------------------------------
    # Zsh
    # --------------------------------------------------------------------------

    if [[ -L "$ZSHRC" && -e "$ZSHRC" ]]; then
        print_success ".zshrc"
    elif [[ -f "$ZSHRC" ]]; then
        print_warning ".zshrc exists but is not managed by this repository"
    else
        print_error ".zshrc is missing"
        ((issues++))
    fi

    # --------------------------------------------------------------------------
    # Zsh Plugins
    # --------------------------------------------------------------------------

    if [[ -L "$ZSH_PLUGINS" && -e "$ZSH_PLUGINS" ]]; then
        print_success ".zsh_plugins.txt"
    elif [[ -f "$ZSH_PLUGINS" ]]; then
        print_warning ".zsh_plugins.txt exists but is not managed by this repository"
    else
        print_error ".zsh_plugins.txt is missing"
        ((issues++))
    fi

    # --------------------------------------------------------------------------
    # tmux
    # --------------------------------------------------------------------------

    if [[ -L "$TMUX_CONFIG" && -e "$TMUX_CONFIG" ]]; then
        print_success "tmux configuration"
    elif [[ -f "$TMUX_CONFIG" ]]; then
        print_warning ".tmux.conf exists but is not managed by this repository"
    else
        print_error ".tmux.conf is missing"
        ((issues++))
    fi

    # --------------------------------------------------------------------------
    # Kitty
    # --------------------------------------------------------------------------

    if [[ -L "$KITTY_CONFIG" && -e "$KITTY_CONFIG" ]]; then
        print_success "Kitty configuration"
    elif [[ -f "$KITTY_CONFIG" ]]; then
        print_warning "Kitty configuration exists but is not managed by this repository"
    else
        print_error "Kitty configuration is missing"
        ((issues++))
    fi

    # --------------------------------------------------------------------------
    # Neovim
    # --------------------------------------------------------------------------

    if [[ -d "$NVIM_CONFIG" ]]; then
        if [[ -f "$NVIM_CONFIG/init.lua" ]]; then
            print_success "Neovim configuration"
        else
            print_error "Neovim configuration exists but init.lua is missing"
            ((issues++))
        fi
    else
        print_error "Neovim configuration is missing"
        ((issues++))
    fi

    # --------------------------------------------------------------------------
    # Dependencies
    # --------------------------------------------------------------------------

    local dependencies=(
        git
        curl
        zsh
        nvim
        tmux
        eza
        rg
        kitty
    )

    for dependency in "${dependencies[@]}"; do
        if command_exists "$dependency"; then
            print_success "$dependency"
        else
            print_error "$dependency is missing"
            ((issues++))
        fi
    done

    echo

    if [[ "$issues" -eq 0 ]]; then
        print_success "Health check passed"
        return 0
    fi

    print_error "Health check found $issues issue(s)"
    return 1
}

# ==============================================================================
# Usage
# ==============================================================================

show_usage() {
    cat <<EOF
Usage: $SCRIPT_NAME [OPTIONS]

Dotfiles setup script.

Options:
    -h, --help          Show this help
    --skip-backup       Do not backup existing configurations
    --check-only        Only run health check
    --force             Continue after installation failures

Examples:
    $SCRIPT_NAME
    $SCRIPT_NAME --check-only
    $SCRIPT_NAME --skip-backup
    $SCRIPT_NAME --force
EOF
}

# ==============================================================================
# Main
# ==============================================================================

main() {
    local skip_backup=false
    local check_only=false
    local force=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_usage
                return 0
                ;;

            --skip-backup)
                skip_backup=true
                shift
                ;;

            --check-only)
                check_only=true
                shift
                ;;

            --force)
                force=true
                shift
                ;;

            *)
                print_error "Unknown option: $1"
                show_usage
                return 1
                ;;
        esac
    done

    : > "$LOG_FILE"

    print_header "Dotfiles Setup"
    log "Starting $SCRIPT_NAME"

    # --------------------------------------------------------------------------
    # Homebrew
    # --------------------------------------------------------------------------

    if ! check_homebrew; then
        return 1
    fi

    # --------------------------------------------------------------------------
    # Dependencies
    # --------------------------------------------------------------------------

    if ! check_dependencies; then
        return 1
    fi

    # --------------------------------------------------------------------------
    # Check Only
    # --------------------------------------------------------------------------

    if [[ "$check_only" == true ]]; then
        health_check
        return $?
    fi

    # --------------------------------------------------------------------------
    # Backup
    # --------------------------------------------------------------------------

    if [[ "$skip_backup" != true ]]; then
        backup_configurations
    fi

    # --------------------------------------------------------------------------
    # Installation
    # --------------------------------------------------------------------------

    local failed=()

    if ! configure_zsh; then
        failed+=("configure_zsh")
    fi

    if ! configure_terminal_tools; then
        failed+=("configure_terminal_tools")
    fi

    if ! install_nvim_config; then
        failed+=("install_nvim_config")

        if [[ "$force" != true ]]; then
            print_error "Neovim configuration installation failed"
            return 1
        fi
    fi

    # --------------------------------------------------------------------------
    # Optional Neovim Tools
    # --------------------------------------------------------------------------

    check_nvim_environment

    # --------------------------------------------------------------------------
    # Final Verification
    # --------------------------------------------------------------------------

    print_header "Final Verification"

    if ! health_check; then
        failed+=("health_check")
    fi

    # --------------------------------------------------------------------------
    # Summary
    # --------------------------------------------------------------------------

    print_header "Installation Summary"

    if [[ ${#failed[@]} -eq 0 ]]; then
        print_success "Installation completed successfully"
    else
        print_warning "Failed steps: ${failed[*]}"

        if [[ "$force" != true ]]; then
            return 1
        fi
    fi

    print_info "Log file: $LOG_FILE"
    print_info "Restart your terminal or run: exec \$SHELL"

    return 0
}

# ==============================================================================
# Entry Point
# ==============================================================================

main "$@"
