alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias vim='nvim'
alias gs='~/bin/gs'
alias cat=bat

export BAT_THEME=TwoDark
export EDITOR=nvim

source "/home/dbalseiro/antigen.zsh"
antigen init ~/.antigenrc

if [ -f ~/.fzf.zsh ];then
  source ~/.fzf.zsh
fi

export PATH=~/.local/bin:~/bin:$PATH
