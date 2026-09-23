#!/usr/bin/env bash
set -euo pipefail

# Detect operating system for compatibility
if [[ "$OSTYPE" == "darwin"* ]]; then
    readonly OS_TYPE="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    readonly OS_TYPE="linux"
else
    readonly OS_TYPE="unknown"
    print_warning "Unknown OS type: $OSTYPE. Some features may not work correctly."
fi

# =============================================================================
# Development Environment Setup Script
# =============================================================================

readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="${SCRIPT_DIR}/setup.log"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# Required dependencies (adjusted for macOS)
readonly REQUIRED_DEPS=(git curl vim antidote eza)
readonly OPTIONAL_DEPS=(zsh)

# macOS-specific adjustments
if [[ "$OS_TYPE" == "macos" ]]; then
    # macOS uses BSD date, which has different format options
    readonly BACKUP_SUFFIX=".$(date +%Y%m%d%H%M%S).backup"
    # Prefer GNU coreutils if available (via brew)
    if command -v gdate >/dev/null 2>&1; then
        readonly DATE_CMD="gdate"
    else
        readonly DATE_CMD="date"
    fi
else
    readonly BACKUP_SUFFIX=".$(date +%Y%m%d%H%M%S).backup"
    readonly DATE_CMD="date"
fi

# =============================================================================
# Utility Functions
# =============================================================================

log() {
    echo "$($DATE_CMD '+%Y-%m-%d %H:%M:%S') - $*" | tee -a "$LOG_FILE"
}

print_header() {
    echo -e "${BLUE}${BOLD}===============================${NC}"
    echo -e "${BLUE}${BOLD}$1${NC}"
    echo -e "${BLUE}${BOLD}===============================${NC}"
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

check_command() {
    command -v "$1" >/dev/null 2>&1
}

backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local backup="${file}${BACKUP_SUFFIX}"
        mv "$file" "$backup"
        print_success "Backed up $file to $backup"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"

    if [[ ! -e "$source" ]]; then
        print_warning "Source file $source does not exist, skipping symlink"
        return 1
    fi

    # Remove existing symlink or file
    [[ -L "$target" || -f "$target" ]] && rm -f "$target"

    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"

    if ln -sf "$source" "$target"; then
        print_success "Created symlink: $target -> $source"
        return 0
    else
        print_error "Failed to create symlink: $target -> $source"
        return 1
    fi
}

download_file() {
    local url="$1"
    local output="$2"
    local description="$3"

    print_info "Downloading $description..."
    if curl -fsSL --connect-timeout 10 --retry 3 "$url" -o "$output"; then
        print_success "Downloaded $description"
        return 0
    else
        print_error "Failed to download $description from $url"
        return 1
    fi
}

# =============================================================================
# Validation Functions
# =============================================================================

check_dependencies() {
    print_header "Checking Dependencies"

    local missing_deps=()

    for dep in "${REQUIRED_DEPS[@]}"; do
        if check_command "$dep"; then
            print_success "$dep is available"
        else
            missing_deps+=("$dep")
            print_error "$dep is required but not installed"
        fi
    done

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        print_info "Please install the missing dependencies and run the script again."
        exit 1
    fi

    # Check optional dependencies
    for dep in "${OPTIONAL_DEPS[@]}"; do
        if check_command "$dep"; then
            print_success "$dep is available (optional)"
        else
            print_warning "$dep is not installed (optional)"
        fi
    done
}

validate_shell() {
    if ! check_command zsh; then
        print_warning "Zsh is not installed. Some features will be skipped."
        return 1
    fi

    # On macOS, default shell changed to zsh in Catalina+
    if [[ "$OS_TYPE" == "macos" ]]; then
        if [[ "$SHELL" != *"zsh" ]]; then
            print_info "macOS defaults to zsh. Current shell: $SHELL"
            print_info "To change default shell: chsh -s \$(which zsh)"
        fi
    else
        if [[ "$SHELL" != *"zsh" ]]; then
            print_warning "Current shell is not zsh. Consider changing default shell with: chsh -s \$(which zsh)"
        fi
    fi

    return 0
}

# =============================================================================
# Installation Functions
# =============================================================================

install_vim_plug() {
    print_header "Installing vim-plug"

    local plug_file="$HOME/.vim/autoload/plug.vim"

    if [[ -f "$plug_file" ]]; then
        print_info "vim-plug already installed, checking for updates..."
        # Try to update vim-plug with timeout and log to avoid hanging
        if timeout 30 vim -es -u NONE -c 'source ~/.vim/autoload/plug.vim | PlugUpgrade | qa' >> "$LOG_FILE" 2>&1; then
            print_success "vim-plug updated successfully"
        else
            print_warning "vim-plug update failed or timed out"
        fi
    else
        print_info "Installing vim-plug..."
        mkdir -p "$(dirname "$plug_file")"
        if download_file \
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
            "$plug_file" \
            "vim-plug"; then
            print_success "vim-plug installed successfully"
        else
            return 1
        fi
    fi
}

install_antidote_check() {
    print_header "Checking Antidote"

    if ! validate_shell; then
        print_warning "Skipping Antidote check (zsh not available)"
        return 0
    fi

    if check_command antidote; then
        print_success "Antidote is installed"
        return 0
    else
        print_error "Antidote is not installed. Please install it using: brew install antidote"
        return 1
    fi
}

backup_configurations() {
    print_header "Backing Up Existing Configurations"

    local configs=(
        "$HOME/.vimrc"
        "$HOME/.zshrc"
        "$HOME/.zsh_plugins.txt"
    )

    for config in "${configs[@]}"; do
        backup_file "$config"
    done
}

configure_vim() {
    print_header "Configuring Vim"

    # Create vim directories
    mkdir -p "$HOME/.vim/config" "$HOME/.vim/backup" "$HOME/.vim/swap" "$HOME/.vim/undo"

    # Link main vimrc
    if [[ -f "$SCRIPT_DIR/.vimrc" ]]; then
        create_symlink "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
    else
        print_warning "No .vimrc found in script directory"
    fi

    # Link vim config files
    if [[ -d "$SCRIPT_DIR/config" ]] && compgen -G "$SCRIPT_DIR/config/*" > /dev/null; then
        print_info "Linking vim configuration files..."
        for config_file in "$SCRIPT_DIR/config/"*; do
            local filename="$(basename "$config_file")"
            create_symlink "$config_file" "$HOME/.vim/config/$filename"
        done
    else
        print_info "No additional vim config files found"
    fi
}

configure_zsh() {
    print_header "Configuring Zsh"

    if ! validate_shell; then
        print_warning "Skipping Zsh configuration"
        return 0
    fi

    if [[ -f "$SCRIPT_DIR/.zshrc" ]]; then
        create_symlink "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
    else
        print_warning "No .zshrc found in script directory"
    fi

    if [[ -f "$SCRIPT_DIR/zsh_plugins.txt" ]]; then
        create_symlink "$SCRIPT_DIR/zsh_plugins.txt" "$HOME/.zsh_plugins.txt"
    else
        print_warning "No zsh_plugins.txt found in script directory"
    fi
}

install_vim_plugins() {
    print_header "Installing Vim Plugins"

    if [[ ! -f "$HOME/.vimrc" ]]; then
        print_warning "No .vimrc found, skipping plugin installation"
        return 0
    fi

    print_info "Installing/updating Vim plugins..."
    if timeout 300 vim +PlugInstall +PlugUpdate +qa 2>/dev/null; then
        print_success "Vim plugins installed/updated successfully"
    else
        print_error "Vim plugin installation failed or timed out"
        return 1
    fi
}

install_pawsh_theme() {
    print_header "Installing Pawsh Theme"

    local theme_dir="$HOME/.zsh/themes"
    local temp_dir="/tmp/pawsh-zsh-theme-$$"

    print_info "Installing/updating pawsh theme..."

    # Clean up any existing temp directory
    rm -rf "$temp_dir"

    if git clone --depth 1 https://github.com/SergioBonatto/pawsh-zsh-theme.git "$temp_dir"; then
        mkdir -p "$theme_dir"
        cp "$temp_dir/pawsh.zsh-theme" "$theme_dir/"
        rm -rf "$temp_dir"
        print_success "Pawsh theme installed/updated successfully at $theme_dir"
    else
        print_error "Failed to clone pawsh theme repository"
        rm -rf "$temp_dir"
        return 1
    fi
}

# =============================================================================
# Health Check Functions
# =============================================================================

run_health_check() {
    print_header "Running Health Check"

    local issues=0

    # Check if symlinks are valid
    local configs=(
        "$HOME/.vimrc"
        "$HOME/.zshrc"
        "$HOME/.zsh_plugins.txt"
    )

    for config in "${configs[@]}"; do
        if [[ -L "$config" ]]; then
            if [[ -e "$config" ]]; then
                print_success "Symlink valid: $config"
            else
                print_error "Broken symlink: $config"
                ((issues++))
            fi
        elif [[ -f "$config" ]]; then
            print_info "Regular file (not symlinked): $config"
        else
            print_warning "Configuration file missing: $config"
        fi
    done

    # Check vim-plug installation
    if [[ -f "$HOME/.vim/autoload/plug.vim" ]]; then
        print_success "vim-plug is installed"
    else
        print_error "vim-plug is not installed"
        ((issues++))
    fi

    # Check Antidote
    if validate_shell && check_command antidote; then
        print_success "Antidote is installed"
    elif validate_shell; then
        print_error "Antidote is not installed"
        ((issues++))
    fi

    # Check eza
    if check_command eza; then
        print_success "eza is installed"
    else
        print_error "eza is not installed"
        ((issues++))
    fi

    if [[ $issues -eq 0 ]]; then
        print_success "Health check completed successfully"
        return 0
    else
        print_error "Health check found $issues issue(s)"
        return 1
    fi
}

# =============================================================================
# Main Function
# =============================================================================

show_usage() {
    cat << EOF
Usage: $SCRIPT_NAME [OPTIONS]

Development Environment Setup Script

OPTIONS:
    -h, --help          Show this help message
    -v, --verbose       Enable verbose logging
    --skip-backup       Skip backing up existing configurations
    --check-only        Only run health check, don't install anything
    --force             Force reinstallation of existing components

Examples:
    $SCRIPT_NAME                    # Run full installation
    $SCRIPT_NAME --check-only       # Only run health check
    $SCRIPT_NAME --skip-backup      # Skip configuration backup

EOF
}

main() {
    local skip_backup=false
    local check_only=false
    local force_install=false
    local verbose=false

    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -v|--verbose)
                verbose=true
                shift
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
                force_install=true
                shift
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done

    # Initialize log file
    : > "$LOG_FILE"

    print_header "Development Environment Setup"
    log "Starting setup script with PID $$"

    # Always run dependency check
    check_dependencies

    if [[ "$check_only" == true ]]; then
        run_health_check
        exit $?
    fi

    # Backup existing configurations
    if [[ "$skip_backup" != true ]]; then
        backup_configurations
    fi

    # Run installation steps
    local steps=(
        install_vim_plug
        install_antidote_check
        configure_vim
        configure_zsh
        install_vim_plugins
        install_pawsh_theme
    )

    local failed_steps=()
    for step in "${steps[@]}"; do
        if ! "$step"; then
            failed_steps+=("$step")
            if [[ "$force_install" != true ]]; then
                print_warning "Step $step failed. Use --force to continue despite failures."
            fi
        fi
    done

    # Run final health check
    print_header "Final Verification"
    run_health_check

    # Summary
    print_header "Installation Summary"
    if [[ ${#failed_steps[@]} -eq 0 ]]; then
        print_success "All installation steps completed successfully!"
    else
        print_warning "Some steps failed: ${failed_steps[*]}"
        print_info "Check the log file for details: $LOG_FILE"
    fi

    print_info "Log file: $LOG_FILE"
    print_info "To apply all changes, restart your terminal or run: exec \$SHELL"

    if [[ ${#failed_steps[@]} -eq 0 ]]; then
        exit 0
    else
        exit 1
    fi
}

# =============================================================================
# Script Entry Point
# =============================================================================

# Trap to clean up on exit
cleanup() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        print_error "Script failed with exit code $exit_code"
        print_info "Check the log file for details: $LOG_FILE"
    fi
}

trap cleanup EXIT

# Run main function with all arguments
main "$@"
