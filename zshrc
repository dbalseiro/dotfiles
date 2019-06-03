export PATH=~/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export ZSH="/home/dbalseiro/.oh-my-zsh"

ZSH_THEME="lambda-mod"
#ZSH_THEME="powerlevel9k/powerlevel9k"
#POWERLEVEL9K_MODE='awesome-fontconfig'
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs status time)
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
#POWERLEVEL9K_COLOR_SCHEME='dark'
#DISABLE_AUTO_TITLE="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

alias cat=bat
export BAT_THEME=TwoDark
# on light theme use:
# export BAT_THEME=GitHub

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# zsh options
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

alias vim=nvim
alias wip="git add -A && git commit -mWIP && git push"
alias nv="nvr -cc vsplit"

alias xgammon="xgammon -doublerfont '-*-clean-*-*-*-*-*-*-*-*-*-*-*-*'"

eval $(opam config env)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function quick-find() {
    homedir=~/plow
    dir=$(find $homedir -type d -not -path '*\/.*' -maxdepth 2 | fzf)
    cd $dir
    zle reset-prompt
}
zle -N quick-find-widget quick-find
bindkey "^p" quick-find-widget

source /etc/profile.d/nix.sh
export NIX_PATH=nixpkgs=/home/dbalseiro/plow/all/nix

export PATH="/home/dbalseiro/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# 4GB memory for node :/
export NODE_OPTIONS=--max_old_space_size=3072

# plow test env
export LocalDevResultFolder=~/all/result
export LocalDevSiteBuildFolder=~/work/testOnping/sitebuild
export LocalDevDockerComposeFolder=~/work/testOnping/sitebuild
export LocalDevTestingPath=~/work/testOnping/
