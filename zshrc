DISABLE_AUTO_TITLE=true
DISABLE_MAGIC_FUNCTIONS=true

# title bar prompt
precmd () {
  print -Pn "\e]0; %1~ \a"
}

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias vim='nvim'
alias pvim='poetry run nvim'
alias gs='~/bin/gs'
alias cat=batcat
alias k=kubectl
alias mk='minikube kubectl --'
alias lastcommit='git log -n 1 --pretty=format:"%H" | pbcopy'
alias build='stack test && prune-juice'
alias tmuxa='tmux attach || tmux'

export BAT_THEME=TwoDark
export EDITOR=nvim

source "/home/dbalseiro/antigen.zsh"
antigen init ~/.antigenrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=~/.local/bin:~/bin:$PATH

export ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[blue]%} "
setopt no_hist_verify

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "/home/dbalseiro/.ghcup/env" ] && . "/home/dbalseiro/.ghcup/env" # ghcup-env

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(pyenv virtualenv-init -)"

# eval "$(oh-my-posh init zsh --config ~/.dbalseiro.omp.json)"

export PATH=~/go/bin:$PATH
export TERM=xterm-256color

alias ls=lsd
eval "$(zoxide init zsh)"
