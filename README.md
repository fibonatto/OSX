# OSX - Development Configuration

This repository contains the current configuration files used to set up a development environment with Zsh, tmux, Kitty, and Neovim.

> **Note:** The `.deprecated` directory contains legacy files kept only for project history. Its contents are outdated, must not be used, and are intentionally not documented here.

## Repository Structure

```
OSX/
├── .zshrc                 # Zsh shell configuration
├── zsh_plugins.txt        # Antidote plugin list
├── tmux.conf              # tmux configuration
├── kitty.conf             # Kitty terminal configuration
└── install.sh             # Automated setup script
```

The current configuration is modularized across this repository and other repositories used by the setup. Neovim is maintained separately in [fibonatto/nvim-config](https://github.com/fibonatto/nvim-config) and is cloned by the installer.

## Key Features

### Zsh Configuration
- **Antidote**: Lightweight Zsh plugin manager
- **eza**: A modern, feature-rich replacement for `ls`
- **Custom prompt**: pawsh-inspired prompt with Git status and contextual state
- **Included plugins**: zsh-syntax-highlighting, zsh-autosuggestions, and Git-related plugins
- **Custom aliases**: Shortcuts for Git, Vim, navigation, and system commands
- **Doom Emacs integration**: Support for using the shell configuration alongside Doom Emacs

### Terminal Configuration
- **tmux**: Custom terminal multiplexer configuration
- **Kitty**: Custom terminal emulator configuration

### Neovim Configuration
Neovim is managed in the separate [fibonatto/nvim-config](https://github.com/fibonatto/nvim-config) repository. The installer clones it into `${XDG_CONFIG_HOME:-$HOME/.config}/nvim`.

## Installation

### Prerequisites

The installer supports macOS and Linux. On macOS, [Homebrew](https://brew.sh) must be installed. The installer checks dependencies but does not install them automatically.

The following commands must be available before running the installer:

- `git`
- `curl`
- `zsh`
- `nvim`
- `tmux`
- `eza`
- `rg` (ripgrep)
- `antidote`
- `kitty`

On macOS, install missing packages with Homebrew, for example:

```bash
brew install git curl zsh neovim tmux eza ripgrep antidote kitty
```

The installer also checks the following optional Neovim tools. They do not prevent installation:

- `clangd`
- `node`
- `npm`
- `typescript-language-server`

### Automated Installation (Recommended)

The installer configures the files in this repository and safely handles existing configuration files. It will:

- Verify Homebrew on macOS and check all required dependencies
- Back up existing Zsh, tmux, Kitty, and Neovim configurations
- Link `.zshrc`, `zsh_plugins.txt`, `tmux.conf`, and `kitty.conf` into your home directory
- Clone the external Neovim configuration into your XDG configuration directory
- Check optional Neovim development tools
- Run a final health check and write details to `setup.log`

#### 1. Clone the repository

```bash
git clone https://github.com/fibonatto/OSX.git ~/osx-dotfiles
cd ~/osx-dotfiles
```

#### 2. Run the installer

```bash
chmod +x install.sh
./install.sh
```

The installer creates timestamped backups next to existing configuration paths. For example, an existing `~/.zshrc` may become `~/.zshrc.20260923120000.backup`.

#### 3. Options

| Option | Description |
|--------|-------------|
| `-h`, `--help` | Show the help message |
| `--skip-backup` | Do not back up existing configurations before installation |
| `--check-only` | Run the health check without installing configurations |
| `--force` | Continue after installation or health-check failures |

**Examples:**

```bash
# Full installation (recommended)
./install.sh

# Only run the health check
./install.sh --check-only

# Skip backups (not recommended)
./install.sh --skip-backup

# Continue after an installation failure
./install.sh --force
```

#### 4. Apply changes

After installation, restart your terminal or run:

```bash
exec $SHELL
```

The installer writes its log to `setup.log` in the repository directory.

### Shell Configuration

If Zsh is not your current login shell, the installer displays the command needed to change it:

```bash
chsh -s "$(command -v zsh)"
```

Restart your terminal after changing the login shell.

## Health Check

Run the health check with:

```bash
./install.sh --check-only
```

A successful health check confirms that the managed configuration links exist, the external Neovim configuration contains `init.lua`, and all required dependencies are available.

## Customization

Edit the current configuration files directly to customize the environment:

- `.zshrc` for shell behavior, aliases, and prompt settings
- `zsh_plugins.txt` for Antidote plugins
- `tmux.conf` for tmux behavior and key bindings
- `kitty.conf` for terminal appearance and behavior
- The external [nvim-config](https://github.com/fibonatto/nvim-config) repository for Neovim settings and plugins

Do not use files from `.deprecated`; they are retained for historical reference only.

## Contributing

Feel free to:

- Report bugs
- Suggest improvements
- Submit pull requests
- Share configuration improvements

## License

This project is under the MIT license. See the LICENSE file for more details.

## Contact

- **Author**: Bonatto
- **GitHub**: [SergioBonatto](https://github.com/SergioBonatto/)

---

These configurations represent a personal development environment. Adapt them as needed for your workflow.
