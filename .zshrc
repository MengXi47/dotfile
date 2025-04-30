export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
DEFAULT_USER=" FUCK"
plugins=(git)

source $ZSH/oh-my-zsh.sh

alias ll='ls -l'
alias App='cd ~/App'

if command -v tmux &>/dev/null; then
  if [ -z "$TMUX" ]; then
    tmux kill-session -t FUCK 2>/dev/null
    tmux new-session -s FUCK
  fi
fi


