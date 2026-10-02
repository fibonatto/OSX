# Aliases

# --- Navigation & system ---
alias q="exit"
alias c="clear"
alias cl="clear"
alias ..="cd .."
alias h="history"
alias j="jobs"
alias grep="grep --color=auto"
alias mkdir="mkdir -p"
alias du="du -h"
alias df="df -h"

# --- Listing (eza) ---
alias ll="eza -la --icons=auto"
alias la="eza -A --icons=auto"
alias l="eza --icons=auto"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# --- Editor ---
for _a in v im vim vom vimm; do alias $_a="nvim"; done

# --- Tmux ---
alias t="tmux"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias tk="tmux kill-session -t"

# --- Git ---
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

alias s="git status"
alias status="git status"
alias add="git add"
alias commit="git commit -m"
alias push="git push"
alias pull="git pull"
alias diff="git diff"
alias branch="git branch"
alias checkout="git checkout"

# --- Development ---
alias ns="npm start"
alias ni="npm install"
alias nt="npm test"
alias nr="npm run"
alias pyserver="python3 -m http.server"
alias mr="math-render"

# --- Search (scripts in ~/Scripts; noglob lets ? and * through) ---
alias '?'='noglob ddg'
alias '??'='noglob tell j-'
alias hn="w3m https://news.ycombinator.com"

# --- Shortcuts ---
alias db="cd ~/Basal && vim index.md"

# --- Typo corrections ---
for _a in claer caler celar clea cler clera; do alias $_a="clear"; done
alias dc="cd"
alias cdd="cd .."
alias gti="git"

unset _a
