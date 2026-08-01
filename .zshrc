HISTFILE=~/.histfile
HISTSIZE=10000000
SAVEHIST=10000000
setopt inc_append_history
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export CLICOLOR=1
export LSCOLORS=cxgxfxexbxegedabagacad
export EDITOR='vim'

PROMPT=$'%B%F{green}%~%b%F{blue}\n$%f '

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
