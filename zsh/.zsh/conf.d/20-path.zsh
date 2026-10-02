# PATH — single source of truth. typeset -U drops duplicates.

typeset -U path PATH

path=(
  $HOME/.npm-global/bin
  $HOME/.config/emacs/bin
  $HOME/.local/bin
  $HOME/Scripts                   # tmux/git scripts repo (adjust if elsewhere)
  /opt/homebrew/opt/llvm/bin
  /opt/homebrew/opt/node@24/bin
  $HOME/.cargo/bin
  $BUN_INSTALL/bin
  $HOME/.opencode/bin
  $HOME/.bend/bin
  $HOME/.grok/bin
  $HOME/.vim/bin
  $PNPM_HOME
  $PNPM_HOME/bin
  /opt/homebrew/bin
  $HOME/go/bin
  $path
)

export PATH

[[ -f "$HOME/.ghcup/env" ]] && source "$HOME/.ghcup/env"
