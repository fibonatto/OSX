# fzf

_fzf_theme() {
  local text="#4A4C52" base="#F2F1EE" base_hl="#E5E3DF" border="#D3D0CA"
  local accent="#9A6F96" blue="#5B8FA8" teal="#4A9690"

  export FZF_DEFAULT_OPTS="--color=fg:$text,bg:$base,hl:$accent,fg+:$text,bg+:$base_hl,hl+:$accent,info:$blue,prompt:$teal,pointer:$teal,marker:$teal,spinner:$teal,header:$teal,border:$border"
}
_fzf_theme && unfunction _fzf_theme

eval "$(fzf --zsh)"
source ~/fzf-git.sh/fzf-git.sh

# Use fd for candidate lists
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() { fd --hidden --exclude .git . "$1"; }
_fzf_compgen_dir()  { fd --type=d --hidden --exclude .git . "$1"; }

# Previews
_fzf_preview_path="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
_fzf_preview_dir="eza --tree --color=always {} | head -200"

export FZF_CTRL_T_OPTS="--preview '$_fzf_preview_path'"
export FZF_ALT_C_OPTS="--preview '$_fzf_preview_dir'"

# Per-command preview for ** completion
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview "$_fzf_preview_dir"  "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"   "$@" ;;
    ssh)          fzf --preview 'dig {}'             "$@" ;;
    *)            fzf --preview "$_fzf_preview_path" "$@" ;;
  esac
}
