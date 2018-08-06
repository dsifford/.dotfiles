# shellcheck shell=bash disable=SC1090

# Source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Initialize Xorg -> sources xinitrc -> starts i3
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx "$XDG_CONFIG_HOME"/X11/xinitrc
