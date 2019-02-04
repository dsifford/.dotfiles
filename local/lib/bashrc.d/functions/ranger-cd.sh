# shellcheck shell=bash
#
# Opens Ranger and on exit, cd into the last directory that Ranger was in.
#

command -v ranger > /dev/null || return

ranger-cd() {
	declare exit_dir
	exit_dir="$(mktemp -t ranger-cd.XXXXXX)"
	ranger --choosedir="$exit_dir" "$(pwd)"
	cd "$(cat "$exit_dir")" && rm "$exit_dir"
}

# <C-o> launches ranger-cd
bind '"\C-o": "ranger-cd\n"'
# FIXME: temp fix for osx since above doesn't work for whatever reason
bind '"\C-p": "ranger-cd\n"'
