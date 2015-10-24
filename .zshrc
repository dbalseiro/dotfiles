# Path to your oh-my-zsh installation.
export ZSH=/Users/diego/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git osx vi-mode)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"
if [ -d ~/bin ]; then
    export PATH=$PATH:~/bin
fi

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
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
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias mutt="(tabtitle Mutt; tabcolors 133 153 0; cd ~/garbage && mutt)"
alias servers="tabtitle Servers; tabcolors 133 153 0; remotes"
alias databases="tabtitle Databases; tabcolors 133 153 0; databases"
alias services="tabtitle Servicios; tabcolors 220 50 47; services"
alias asanaprofile="tabtitle Asana; tabcolors 181 137   0;cd $ASANA_PATH; ./asana-cli"
alias gcabadev="tabtitle GCABA-IO; tabcolors 108 113 196;cd $gcba_home/source/back-end;vim"
alias lynx="(cd ~/torrents ; lynx)"
export EDITOR='vim'
export GOPATH=~/gocode
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

tabcolors 203 75 22

export jboss_home=~/jboss-as-7.1.1.Final

#bindkey -v
#
#function zle-line-init zle-keymap-select {
#    VIM_PROMPT="%{$fg[red]%}%{$reset_color%}%{$bg_bold[red]%}%{$fg[black]%} NORMAL %{$reset_color%}"
#    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#    zle reset-prompt
#}
#
#zle -N zle-line-init
#zle -N zle-keymap-select
#
export KEYTIMEOUT=1
export JAVA_HOME=$(/usr/libexec/java_home)
