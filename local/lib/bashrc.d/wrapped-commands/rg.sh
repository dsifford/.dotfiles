# shellcheck shell=bash
#
# Pipe rg results to less if not already being piped somewhere else
#

command -v rg > /dev/null || return

rg() {
	if [ -t 1 ]; then
		command rg -p "$@" | less -FMRX
	else
		command rg "$@"
	fi
}
