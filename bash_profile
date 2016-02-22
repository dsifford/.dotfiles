#
# ~/.bash_profile
#

# Source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Initialize Xorg -> sources xinitrc -> starts	 i3
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
