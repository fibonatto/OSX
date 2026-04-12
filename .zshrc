# ==============================================================================
# 1. ENVIRONMENT VARIABLES
# ==============================================================================

export EDITOR="vim"
export HISTSIZE=10000
export SAVEHIST=10000

# ==============================================================================
# 2. PATHS & BINARIES
# ==============================================================================

typeset -U path PATH

path=(
  $HOME/.config/emacs/bin
  $HOME/.local/bin
  /opt/homebrew/opt/llvm/bin
  /opt/homebrew/opt/node@24/bin
  $path
)

export PATH

# Bun
if [[ -d "$HOME/.bun" ]]; then
  export BUN_INSTALL="$HOME/.bun"
  path=("$BUN_INSTALL/bin" $path)
  [[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
fi

export PATH="/opt/homebrew/bin:$PATH"

# ==============================================================================
# 3. ZSH OPTIONS & HISTORY
# ==============================================================================

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt PROMPT_SUBST

autoload -U colors && colors

# ==============================================================================
# 4. COMPLETION SYSTEM
# ==============================================================================
autoload -Uz compinit

if [[ -n ~/.zcompdump(N.mh+24) ]]; then
  compinit -d ~/.zcompdump -u
else
  compinit -C -d ~/.zcompdump -u
fi

[[ ~/.zcompdump -nt ~/.zcompdump.zwc ]] && zcompile ~/.zcompdump


# Compile completion cache
if [[ ! -f ~/.zcompdump.zwc || ~/.zcompdump -nt ~/.zcompdump.zwc ]]; then
  zcompile ~/.zcompdump
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:*:*:*' menu yes select

# ==============================================================================
# 5. PLUGINS
# ==============================================================================

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zsh_plugins="$HOME/.zsh_plugins.txt"
zsh_plugins_compiled="$HOME/.zsh_plugins.zsh"

if [[ ! -f "$zsh_plugins_compiled" || "$zsh_plugins" -nt "$zsh_plugins_compiled" ]]; then
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
  antidote bundle < "$zsh_plugins" > "$zsh_plugins_compiled"
fi

source "$zsh_plugins_compiled"

# ==============================================================================
# 6. THEME
# ==============================================================================

source ~/.zsh/themes/pawsh.zsh-theme

# ==============================================================================
# 7. ALIASES
# ==============================================================================

# --- Navigation & System ---
alias q="exit"
alias c="clear"
alias cl="clear"

alias ll="eza -la --icons"
alias la="eza -A --icons"
alias l="eza --icons"
alias ls="eza --icons"

alias ..="cd .."
alias grep="grep --color=auto"
alias mkdir="mkdir -p"
alias h="history"
alias j="jobs"
alias du="du -h"
alias df="df -h"
alias v="vim"

# --- Typo Corrections ---
alias dc="cd"
alias cdd="cd .."
alias claer="clear"
alias caler="clear"
alias celar="clear"
alias clea="clear"
alias cler="clear"
alias clera="clear"
alias im="vim"
alias vom="vim"
alias vimm="vim"
alias gti="git"
alias db="cd ~/Basal && vim index.md"

# --- Git Operations ---
alias gs="git status"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit -m"
alias gca="git commit -am"
alias gp="git push"
alias gpl="git pull"
alias gl="git log --oneline"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gm="git merge"

alias push="git push"
alias pull="git pull"
alias commit="git commit -m"
alias add="git add"
alias status="git status"
alias s="git status"
alias remove="git remote remove origin"
alias diff="git diff"
alias branch="git branch"
alias checkout="git checkout"

# --- Development Tools ---
alias ns="npm start"
alias ni="npm install"
alias nt="npm test"
alias nr="npm run"

# ==============================================================================
# 8. FUNCTIONS
# ==============================================================================

mkcd() {
  mkdir -p "$1" && cd "$1"
}

killp() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: killp <process_name>"
    return 1
  fi

  if ! pgrep "$1" >/dev/null; then
    echo "No process found for: $1"
    return 1
  fi

  pkill "$1"
}

extract() {
  if [[ ! -f "$1" ]]; then
    echo "'$1' is not a valid file"
    return 1
  fi

  case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz)  tar xzf "$1" ;;
    *.bz2)     bunzip2 "$1" ;;
    *.rar)     command -v unrar >/dev/null && unrar e "$1" ;;
    *.gz)      gunzip "$1" ;;
    *.tar)     tar xf "$1" ;;
    *.tbz2)    tar xjf "$1" ;;
    *.tgz)     tar xzf "$1" ;;
    *.zip)     unzip "$1" ;;
    *.Z)       uncompress "$1" ;;
    *.7z)      command -v 7z >/dev/null && 7z x "$1" ;;
    *)         echo "'$1' cannot be extracted" ;;
  esac
}

# ==============================================================================
# 9. LAZY LOADING
# ==============================================================================

nvm() {
  unset -f nvm node npm
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  nvm "$@"
}

node() {
  unset -f node
  nvm use default >/dev/null 2>&1
  node "$@"
}

npm() {
  unset -f npm
  nvm use default >/dev/null 2>&1
  npm "$@"
}

rbenv() {
  unset -f rbenv
  if command -v rbenv >/dev/null 2>&1; then
    eval "$(rbenv init -)"
  fi
  rbenv "$@"
}

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
