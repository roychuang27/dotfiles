# [[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export CLICOLOR=1
export PS1="\[\e[1;32m\]\w\[\e[1;34m\]\n$\[\e[m\] "
export LSCOLORS=cxgxfxexbxegedabagacad
export EDITOR='vim'
