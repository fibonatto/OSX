# ~/.zshrc — loader only. Configuration lives in ~/.zsh/conf.d/*.zsh,
# sourced in filename order (the numeric prefix sets the order).

for _f in "$HOME"/.zsh/conf.d/*.zsh(N); do
  source "$_f"
done
unset _f

# Machine-specific overrides and lines appended by installers
# [[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
