# OSX - Development Configuration

This repository contains custom configurations for development environments, including Zsh, tmux, Kitty, and Neovim.

## Repository Structure

```
OSX/
├── .zshrc                 # Zsh shell configuration
├── zsh_plugins.txt        # Antidote plugin list
├── tmux.conf              # tmux configuration
├── kitty.conf             # Kitty terminal configuration
├── install.sh             # Automated setup script
├── setup.log              # Installer log (created at runtime)
├── .vimrc                 # Legacy Vim configuration
├── config/                # Modular Vim configurations
│   ├── plugins.vim        # Plugin management
│   ├── settings.vim       # Basic settings
│   ├── mappings.vim        # Keyboard shortcuts
│   ├── theme.vim           # Theme configuration
│   ├── plugin-config.vim   # Plugin-specific configuration
│   └── statusline.vim      # Status line configuration
├── atomonelight.vim       # Custom Atom One Light theme
├── bonatto.vim            # Custom Bonatto theme
├── statusline.vim         # Custom status line
├── wallpaper-black.png    # Wallpaper
└── reuvolucionario.jpeg   # Additional image
```

## Key Features

### Zsh Configuration
- **Antidote**: Lightning-fast Zsh plugin manager
- **eza**: A modern, feature-rich replacement for `ls`
- **Theme**: pawsh (lightweight, minimal prompt with no framework dependency)
- **Theme Features**:
  - Contextual cat prompt (`ᓚᘏᗢ`) based on exit status
  - Fast Git status display (staged, modified, untracked, deleted, ahead/behind)
  - Vi mode awareness and virtualenv visibility
  - Prompt refresh on keymap change
- **Included plugins**:
  - zsh-syntax-highlighting, zsh-autosuggestions
  - gitignore (via Oh My Zsh plugins)
- **Custom aliases**: Optimized for Git, Vim, and system navigation using `eza`
- **Doom Emacs integration**: Configuration for joint usage

### Terminal Configuration
- **tmux**: Custom terminal multiplexer configuration
- **Kitty**: Custom terminal emulator configuration

### Neovim Configuration
The installer clones the Neovim configuration from [fibonatto/nvim-config](https://github.com/fibonatto/nvim-config) into `${XDG_CONFIG_HOME:-$HOME/.config}/nvim`.

### Vim Configuration
The repository also includes a legacy modular Vim configuration with custom themes, plugins, mappings, and OCaml support.

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

Optional Neovim tooling is also checked, but does not prevent installation:

- `clangd`
- `node`
- `npm`
- `typescript-language-server`

### Automated Installation (Recommended)

The installer configures the files in this repository and safely handles existing configuration files. It will:

- Verify Homebrew on macOS and check all required dependencies
- Back up existing Zsh, tmux, Kitty, and Neovim configurations
- Link `.zshrc`, `zsh_plugins.txt`, `tmux.conf`, and `kitty.conf` into your home directory
- Clone the Neovim configuration into your XDG configuration directory
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

The installer creates timestamped backups next to existing configuration paths, using the format `.backup` with a timestamp. For example, an existing `~/.zshrc` may become `~/.zshrc.20260923120000.backup`.

#### 3. Options

| Option | Description |
|--------|-------------|
| `-h`, `--help` | Show the help message |
| `--skip-backup` | Do not back up existing configurations before installation |
| `--check-only` | Run the health check without installing configurations |
| `--force` | Continue and return successfully after installation or health-check failures |

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

A successful health check confirms that the managed configuration links exist, the Neovim configuration contains `init.lua`, and all required dependencies are available. The command still performs the prerequisite checks before running the health check.

## Custom Themes

### Atom One Light
- Theme based on the official Atom theme
- Optimized for clarity and readability
- Harmonious colors for long coding sessions

### Bonatto Theme
- Exclusive custom theme
- Unique and modern color palette
- Distinctive styles for code elements

## Main Shortcuts

### Vim
- **Leader key**: `,` (comma)
- **Quick navigation**: `Shift+j/k` for 6-line movement
- **Word navigation**: `Shift+h/l` for beginning/end of word
- **Windows**: `Ctrl+h/j/k/l` for panel navigation
- **Resize**: Arrow keys to adjust windows

### Zsh Aliases
- **Git shortcuts**: `push`, `pull`, `commit`, `add`, `status`
- **Navigation**: `q` (exit), `c` (clear), `cdd` (cd ..)
- **Vim**: `v`, `im`, `vom` (all open Vim)

## Customization

### Adding New Vim Plugins
Edit `config/plugins.vim`:

```vim
Plug 'author/plugin-name'
```

Run `:PlugInstall` in Vim.

### Modifying Shortcuts

Edit `config/mappings.vim` to add or modify shortcuts.

### Customizing Themes

- Modify `atomonelight.vim` or `bonatto.vim`
- Or create your own theme based on the existing structure

## Contributing

Feel free to:
- Report bugs
- Suggest improvements
- Submit pull requests
- Share your customizations

## License

This project is under the MIT license. See the LICENSE file for more details.

## Contact

- **Author**: Bonatto
- **GitHub**: [SergioBonatto](https://github.com/SergioBonatto/)

---

These configurations have been tested on macOS and represent a personal development environment. Adapt as needed for your workflow.
