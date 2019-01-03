# Path to your oh-my-zsh installation.
export ZSH=/Users/dbalseiro/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs status time)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_COLOR_SCHEME='dark'
DISABLE_AUTO_TITLE="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git osx zsh-syntax-highlighting)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

for NEWPATH in ~/bin ~/.local/bin; do
    if [ -d $NEWPATH ]; then
        export PATH=$PATH:$NEWPATH
    fi
done

source $ZSH/oh-my-zsh.sh

# zsh options
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
#
export LC_ALL=es_AR.UTF-8  
export LANG=es_AR.UTF-8

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias vim=nvim
alias cat=bat

export EDITOR='nvim'
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

export KEYTIMEOUT=1

#Fuzzy Find all the things
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function quick-find() {
    homedir=~/plow
    dir=$(find $homedir -type d -not -path '*\/.*' -maxdepth 2 | fzf)
    cd $dir
    zle reset-prompt
}
zle -N quick-find-widget quick-find
bindkey "^p" quick-find-widget
