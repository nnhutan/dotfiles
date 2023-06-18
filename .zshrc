if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
ZVM_INIT_MODE='sourcing'

plugins=(
  git
  zsh-vi-mode
  tmux tmuxinator
  rails
  ruby
  rails
  python
  fast-syntax-highlighting
  bundler
)

source $ZSH/oh-my-zsh.sh

alias mux=tmuxinator
alias cls=clear
alias v=nvim
alias va="nvim ."

export EDITOR='nvim'
export GPG_TTY=$TTY
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=/Users/lixibox/go/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PATH=$PATH:/path/to/driver
eval "$(rbenv init -)"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


