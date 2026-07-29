#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


if [[ "$(tty)" == "/dev/tty1" && -z "$WAYLAND_DISPLAY" && -z "$DISPLAY" && -z "$WM_STARTED" ]]; then
        export WM_STARTED=1
        mango
fi
