DISABLE_AUTO_TITLE="true"
DISABLE_MAGIC_FUNCTIONS=true

# title bar prompt
precmd () {
  print -Pn "\e]0; %1~ \a"
}

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias vim='nvim'
alias pvim='poetry run vim'
alias gs='~/bin/gs'
alias cat=batcat
alias k=kubectl
alias mk='minikube kubectl --'
alias lastcommit='git log -n 1 --pretty=format:"%H" | pbcopy'
alias build='stack test && prune-juice'

export BAT_THEME=TwoDark
export EDITOR=nvim

source "/home/dbalseiro/antigen.zsh"
antigen init ~/.antigenrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=~/.local/bin:~/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

setopt no_hist_verify

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.config/emacs/bin"
# source <(kubectl completion zsh)

[ -f "/home/dbalseiro/.ghcup/env" ] && source "/home/dbalseiro/.ghcup/env" # ghcup-env

eval "$(/home/dbalseiro/.rbenv/bin/rbenv init - zsh)"

# GO Binaries
PATH=$PATH:/usr/local/go/bin
