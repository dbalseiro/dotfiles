# Path to your oh-my-zsh installation.
export ZSH=/Users/diego/.oh-my-zsh

POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs status time)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_COLOR_SCHEME='dark'
DISABLE_AUTO_TITLE="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git osx brew zsh-syntax-highlighting)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/diego/.local/bin"
# export MANPATH="/usr/local/man:$MANPATH"
if [ -d ~/bin ]; then
    export PATH=$PATH:~/bin
fi
export PATH=$PATH:~/Applications/instantclient_11_2

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
#
export LC_ALL=es_AR.UTF-8  
export LANG=es_AR.UTF-8


function gt() {
    clear
    git $@
    git status
}

function tabcolors() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

function tabtitle() {
    echo -ne "\e]1;$@\a"
}

export ASANA_PATH=/Users/diego/gocode/src/github.com/dbalseiro/asana
export gcba_home=~/git/gcaba-io
export pad_home=~/git/pad.ws
export pad_circulo_home=~/git/padcirculohome


alias zc="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias mutt="(tabtitle Mutt; tabcolors 133 153 0; cd ~/garbage && mutt)"
alias servers="tabtitle Servers; tabcolors 133 153 0; remotes"
alias databases="tabtitle Databases; tabcolors 133 153 0; databases"
alias services="tabtitle Servicios; tabcolors 220 50 47; services"
alias asanaprofile="tabtitle Asana; tabcolors 181 137   0;cd $ASANA_PATH; ./asana-cli"
alias gcabadev="tabtitle GCABA-IO; tabcolors 108 113 196;cd $gcba_home/source/back-end;vim"
alias paddev="tabtitle MB-PAD; tabcolors 108 113 196;cd $pad_home/PAD.WS;vim"
alias pinkflowdev="tabtitle MB-PINKFLOW; tabcolors 108 113 196;cd $pad_home/Pinkflow;vim"
alias paddevwf="tabtitle MB-PAD; tabcolors 108 113 196;cd $pad_home/wildfly/pad;vim"
alias pinkflowdevwf="tabtitle MB-PINKFLOW; tabcolors 108 113 196;cd $pad_home/wildfly/pinkflow-base-project;vim"
alias mbdev="tabtitle MB-ONLINE; tabcolors 108 113 196;vim /Volumes/git/mb-circulo-mbfonline"
alias lynx="(cd ~/torrents ; lynx)"
alias padcirculodev="tabtitle MB-CIRCULO-PINKFLOW; tabcolors 108 113 196;$pad_circulo_home/pad-circulo;vim"
alias pinkflowcirculodev="tabtitle MB-CIRCULO-PINKFLOW; tabcolors 108 113 196;cd $pad_circulo_home/pinkflow-circulo;vim"
alias t="~/bin/todo/todo.sh"
alias br="bin/rails"

export EDITOR='vim'
export GOPATH=~/gocode
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

tabcolors 203 75 22

export jboss_home=~/jboss-as-7.1.1.Final
export JBOSS_HOME=~/jboss-as-7.1.1.Final

export KEYTIMEOUT=1
export JAVA_HOME=$(/usr/libexec/java_home)


[ -s "/Users/diego/.dnx/dnvm/dnvm.sh" ] && . "/Users/diego/.dnx/dnvm/dnvm.sh" # Load dnvm

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
export PATH="/usr/local/sbin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
