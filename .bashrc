#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export CLICOLOR=1
export PS1="\[\e[1;32m\]\w\[\e[1;34m\]\n$\[\e[m\] "
export LSCOLORS=cxgxfxexbxegedabagacad
export EDITOR='vim'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/roychuang/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/roychuang/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/roychuang/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/roychuang/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

