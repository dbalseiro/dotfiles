# Path to your oh-my-zsh installation.
export ZSH=/Users/dbalseiro/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs status)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_COLOR_SCHEME='dark'
DISABLE_AUTO_TITLE="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git osx brew zsh-syntax-highlighting)

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

function tabcolors() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

function tabtitle() {
    echo -ne "\e]1;$@\a"
}

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias mutt="(tabtitle MUTT; tabcolors 133 153 0; cd ~/garbage && mutt)"
alias weechat="(tabcolors 0 133 153; weechat)"
alias lynx="(cd ~/torrents ; lynx)"
alias t="~/bin/todo/todo.sh"
alias vim=nvim
alias cbt="stack clean && stack build && stack test"
alias sb="stack build"
alias st="stack test"
alias cat=ccat
alias date=gdate

export EDITOR='nvim'
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

tabcolors 0

export KEYTIMEOUT=1

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}


#dias sin fumar...
diasSinFumar

#Fuzzy Find all the things
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
source $HOME/.cargo/env
export NVM_DIR="$HOME/.nvm" 
. "/usr/local/opt/nvm/nvm.sh"

#PATH=/Users/dbalseiro/Library/Python/2.7/lib/python/site-packages/:$PATH
