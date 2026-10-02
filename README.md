# OSX

Personal macOS development environment configuration.

The repository contains the configuration files used for Zsh, tmux, Kitty, and the installation of the external Neovim configuration.

> **Note:** The `.deprecated` directory contains legacy files kept only for project history. Its contents are outdated, must not be used, and are intentionally not documented here.

## Repository Structure

```text
OSX/
├── .zshrc
├── gatto.heic
├── git_create.sh
├── install.sh
├── kitty/
│   ├── dark-theme.auto.conf
│   ├── dark.conf
│   ├── kitty.app.icns
│   ├── kitty.conf
│   ├── light-theme.auto.conf
│   ├── light.conf
│   └── tmux.conf
├── README.md
├── zsh/
│   ├── .zsh/
│   │   ├── conf.d/
│   │   │   ├── 10-env.zsh
│   │   │   ├── 20-path.zsh
│   │   │   ├── 30-options.zsh
│   │   │   ├── 40-completion.zsh
│   │   │   ├── 50-plugins.zsh
│   │   │   ├── 60-aliases.zsh
│   │   │   ├── 70-functions.zsh
│   │   │   ├── 80-fzf.zsh
│   │   │   └── 90-zoxide.zsh
│   │   └── themes/
│   │       └── pawsh.zsh-theme
│   └── .zshrc
└── zsh_plugins.txt
```

Neovim is maintained separately in [fibonatto/nvim-config](https://github.com/fibonatto/nvim-config) and is cloned by the installer.

## Configuration

### Zsh

The Zsh configuration is split into numbered files under `zsh/.zsh/conf.d/`:

* `10-env.zsh`: environment configuration
* `20-path.zsh`: PATH configuration
* `30-options.zsh`: Zsh options
* `40-completion.zsh`: completion configuration
* `50-plugins.zsh`: plugin setup
* `60-aliases.zsh`: aliases
* `70-functions.zsh`: shell functions
* `80-fzf.zsh`: fzf configuration
* `90-zoxide.zsh`: zoxide configuration

The custom `pawsh` theme is located at:

```text
zsh/.zsh/themes/pawsh.zsh-theme
```

The repository-level `zsh/.zshrc` loads this configuration.

`zsh_plugins.txt` contains the Antidote plugin list.

### Kitty

Kitty configuration is contained entirely in `kitty/`.

```text
kitty/
├── dark-theme.auto.conf
├── dark.conf
├── kitty.app.icns
├── kitty.conf
├── light-theme.auto.conf
├── light.conf
└── tmux.conf
```

The installer links:

```text
kitty/kitty.conf
    -> ~/.config/kitty/kitty.conf
```

The additional theme files are kept alongside the main Kitty configuration.

### tmux

The tmux configuration is stored under `kitty/tmux.conf` and is linked by the installer to:

```text
~/.tmux.conf
```

### Neovim

Neovim is maintained separately:

```text
https://github.com/fibonatto/nvim-config
```

The installer clones it into:

```text
${XDG_CONFIG_HOME:-$HOME/.config}/nvim
```

The Neovim configuration is not stored in this repository.

## Installation

### Prerequisites

The installer supports macOS and Linux.

On macOS, Homebrew must already be installed. The installer checks dependencies but does not install them automatically.

Required commands:

* `git`
* `curl`
* `zsh`
* `nvim`
* `tmux`
* `eza`
* `rg`
* `kitty`
* `antidote`

On macOS, missing dependencies can be installed with:

```bash
brew install git curl zsh neovim tmux eza ripgrep antidote kitty
```

The installer also checks these optional Neovim tools:

* `clangd`
* `node`
* `npm`
* `typescript-language-server`

Missing optional tools do not prevent installation.

### Automated Installation

Clone the repository:

```bash
git clone https://github.com/fibonatto/OSX.git ~/osx-dotfiles
cd ~/osx-dotfiles
```

Run the installer:

```bash
chmod +x install.sh
./install.sh
```

The installer:

1. Checks Homebrew on macOS.
2. Checks required dependencies.
3. Backs up existing configuration files.
4. Links the repository's Zsh configuration.
5. Links the Antidote plugin list.
6. Links the Kitty configuration.
7. Links the tmux configuration.
8. Clones the external Neovim configuration if necessary.
9. Checks optional Neovim tools.
10. Runs a final health check.

Existing configuration files are backed up with a timestamp suffix:

```text
~/.zshrc.20261002123456.backup
~/.tmux.conf.20261002123456.backup
```

### Options

| Option          | Description                             |
| --------------- | --------------------------------------- |
| `-h`, `--help`  | Show the help message                   |
| `--skip-backup` | Skip configuration backups              |
| `--check-only`  | Run the health check without installing |
| `--force`       | Continue after installation failures    |

Examples:

```bash
# Full installation
./install.sh

# Check the current installation
./install.sh --check-only

# Install without creating backups
./install.sh --skip-backup

# Continue after an installation failure
./install.sh --force
```

After installation, restart the shell:

```bash
exec $SHELL
```

The installer writes its log to:

```text
setup.log
```

## Managed Files

The installer manages these files:

| Repository         | Destination                  |
| ------------------ | ---------------------------- |
| `zsh/.zshrc`       | `~/.zshrc`                   |
| `zsh_plugins.txt`  | `~/.zsh_plugins.txt`         |
| `kitty/kitty.conf` | `~/.config/kitty/kitty.conf` |
| `kitty/tmux.conf`  | `~/.tmux.conf`               |

Neovim is cloned separately into:

```text
${XDG_CONFIG_HOME:-$HOME/.config}/nvim
```

## Health Check

Run:

```bash
./install.sh --check-only
```

The health check verifies:

* Zsh configuration link
* Antidote plugin list link
* tmux configuration link
* Kitty configuration link
* Neovim configuration
* Required dependencies

A successful check reports:

```text
Health check passed
```

## Customization

Edit the files in this repository directly.

For Zsh:

```text
zsh/.zshrc
zsh/.zsh/conf.d/
zsh/.zsh/themes/pawsh.zsh-theme
zsh_plugins.txt
```

For Kitty and tmux:

```text
kitty/
```

Neovim is customized in the separate [nvim-config](https://github.com/fibonatto/nvim-config) repository.

## License

MIT License.

