# Plugins (antidote) and prompt theme

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

_plugins_src="$HOME/.zsh_plugins.txt"
_plugins_bundle="$HOME/.zsh_plugins.zsh"

# Rebuild the static bundle only when the plugin list changes
if [[ ! -f "$_plugins_bundle" || "$_plugins_src" -nt "$_plugins_bundle" ]]; then
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
  antidote bundle < "$_plugins_src" > "$_plugins_bundle"
fi

source "$_plugins_bundle"
unset _plugins_src _plugins_bundle

source ~/.zsh/themes/pawsh.zsh-theme
