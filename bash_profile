# shellcheck shell=bash disable=SC1090
#
# ~/.bash_profile
#

declare newpath
declare -a path=(
	~/.local/bin
	"$XDG_DATA_HOME"/{cargo,go,npm}/bin
	/usr/local/opt/openssl/bin
	/usr/local/opt/*/libexec/gnubin
	/usr/local/{bin,sbin}
)

mapfile -t path < <(
	cat \
		<(printf '%s\n' "${path[@]}") \
		<(echo "$PATH" | tr ':' '\n') \
		<(getconf PATH | tr ':' '\n')
)

# Prune out non-existent paths
while read -r; do
	[ ! -d "$REPLY" ] && continue
	newpath="${newpath:+$newpath:}$REPLY"
done < <(awk '!x[$0]++' < <(printf '%s\n' "${path[@]}"))

PATH="$newpath"
unset path newpath

# Source profile
[[ -f ~/.profile ]] && . ~/.profile

# Source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start ssh-agent keychain
eval "$(keychain --absolute --dir "$XDG_RUNTIME_DIR/keychain" --eval --quiet id_rsa)"

# Initialize Xorg -> sources xinitrc -> starts i3
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx "$XDG_CONFIG_HOME"/X11/xinitrc

# vim: set ft=sh:
