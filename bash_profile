# shellcheck shell=bash disable=SC1090
#
# ~/.bash_profile
#

# Source pathrc
[[ -f ~/.dotfiles/pathrc ]] && . ~/.dotfiles/pathrc

# Source profile
[[ -f ~/.profile ]] && . ~/.profile

# Source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start ssh-agent keychain
eval "$(keychain --absolute --dir "$XDG_RUNTIME_DIR/keychain" --eval --quiet id_ed25519)"

# Initialize Xorg -> sources xinitrc -> starts i3
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx "$XINITRC"

# vim: set ft=sh:
