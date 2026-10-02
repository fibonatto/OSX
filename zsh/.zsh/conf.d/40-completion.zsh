# Completion

fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit

# Full security check once a day, cached dump otherwise
if [[ -n ~/.zcompdump(N.mh+24) ]]; then
  compinit -d ~/.zcompdump
else
  compinit -C -d ~/.zcompdump
fi

[[ ! -f ~/.zcompdump.zwc || ~/.zcompdump -nt ~/.zcompdump.zwc ]] && zcompile ~/.zcompdump

[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:*:*:*' menu yes select
