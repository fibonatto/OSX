#!/bin/sh
dir="$HOME/.config/kitty"
kitten=/Applications/kitty.app/Contents/MacOS/kitten
bg=$($kitten @ get-colors | awk '$1=="background"{print tolower($2)}')
if [ "$bg" = "#f2f1ee" ]; then f=dark.conf; else f=light.conf; fi
$kitten @ set-colors -a -c "$dir/$f"
