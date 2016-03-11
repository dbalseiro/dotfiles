# Path to your oh-my-zsh installation.
export ZSH=/Users/diego/.oh-my-zsh

ZSH_THEME="agnoster"
DISABLE_AUTO_TITLE="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git osx vi-mode brew)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"
if [ -d ~/bin ]; then
    export PATH=$PATH:~/bin
fi

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

function tabcolors() {
    echo "\033]6;1;bg;red;brightness;$1\a"
    echo "\033]6;1;bg;green;brightness;$2\a"
    echo "\033]6;1;bg;blue;brightness;$3\a"
}

function tabtitle() {
    echo -ne "\e]1;$@\a"
}

export ASANA_PATH=/Users/diego/gocode/src/github.com/dbalseiro/asana
export gcba_home=~/git/gcaba-io
export pad_home=~/git/padhome

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias mutt="(tabtitle Mutt; tabcolors 133 153 0; cd ~/garbage && mutt)"
alias servers="tabtitle Servers; tabcolors 133 153 0; remotes"
alias databases="tabtitle Databases; tabcolors 133 153 0; databases"
alias services="tabtitle Servicios; tabcolors 220 50 47; services"
alias asanaprofile="tabtitle Asana; tabcolors 181 137   0;cd $ASANA_PATH; ./asana-cli"
alias gcabadev="tabtitle GCABA-IO; tabcolors 108 113 196;cd $gcba_home/source/back-end;vim"
alias paddev="tabtitle MB-PAD; tabcolors 108 113 196;cd $pad_home;vim"
alias lynx="(cd ~/torrents ; lynx)"

export EDITOR='vim'
export GOPATH=~/gocode
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

tabcolors 203 75 22

export jboss_home=~/jboss-as-7.1.1.Final

export KEYTIMEOUT=1
export JAVA_HOME=$(/usr/libexec/java_home)
