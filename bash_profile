# shellcheck shell=bash disable=SC1090
#
# ~/.bash_profile
#

# Source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start ssh-agent
eval "$(ssh-agent)" > /dev/null && ssh-add -q

# Initialize Xorg -> sources xinitrc -> starts i3
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx "$XDG_CONFIG_HOME"/X11/xinitrc

# vim: set ft=sh:
