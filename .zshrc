export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git)
source $ZSH/oh-my-zsh.sh

prompt_context() {
  if [[ -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%n@%m"
  fi
}
 
prompt_status() {
  local -a symbols
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}
 
prompt_dir() {
  prompt_segment 141 black "%2~"
}
 
alias ll='ls -lah'
alias tk='tmux kill-server'
alias icloud='/Users/boen/Library/Mobile\ Documents/com~apple~CloudDocs'
alias py='python3'
alias oc='opencode'
alias cl='claude'
alias clp='claude --dangerously-skip-permissions'
 
if command -v tmux &>/dev/null; then
  if [ -z "$TMUX" ] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
    count=$(tmux list-sessions 2>/dev/null | wc -l)
    session_name="S$((count + 1))"
    tmux new-session -s "$session_name"
  fi
fi
 
export CC="/opt/homebrew/opt/llvm/bin/clang"
export CXX="/opt/homebrew/opt/llvm/bin/clang++"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
 
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib ${LDFLAGS}"
export LDFLAGS="-L/opt/homebrew/opt/curl/lib ${LDFLAGS}"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib ${LDFLAGS}"
 
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include ${CPPFLAGS}"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include ${CPPFLAGS}"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include ${CPPFLAGS}"
 
export PKG_CONFIG_PATH="/opt/homebrew/opt/curl/lib/pkgconfig:/opt/homebrew/opt/zlib/lib/pkgconfig:${PKG_CONFIG_PATH}"
 
export CMAKE_PREFIX_PATH="$(brew --prefix zlib):${CMAKE_PREFIX_PATH}"

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"export CLAUDE_CODE_NO_FLICKER=1