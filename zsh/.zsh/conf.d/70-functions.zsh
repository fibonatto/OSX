# Functions that must run in the current shell, plus lazy loaders
# (anything that can be a standalone script lives in ~/Scripts instead)

mkcd() {
  mkdir -p "$1" && cd "$1"
}

# --- nvm: loaded on first use of nvm/node/npm/npx ---
_load_nvm() {
  unset -f nvm node npm npx
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
}

nvm() { _load_nvm; nvm "$@"; }

for _cmd in node npm npx; do
  eval "$_cmd() { _load_nvm; nvm use default >/dev/null 2>&1; $_cmd \"\$@\"; }"
done
unset _cmd

# --- rbenv ---
rbenv() {
  unset -f rbenv
  command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"
  rbenv "$@"
}

# --- thefuck ---
fuck() { unset -f fuck; eval "$(thefuck --alias)"; fuck "$@"; }
fk()   { unset -f fk;   eval "$(thefuck --alias fk)"; fk "$@"; }


# --- nvim open from fzf ---
fim() {
    local file
    file="$(fzf --preview='cat {}')" || return
    nvim "$file"
}


# --- fzf with cat ---
fat() {
    local file
    file="$(fzf --preview='cat {}')" || return
    "$file"
}
