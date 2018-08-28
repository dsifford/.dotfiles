# shellcheck shell=bash
#
# Stub out "hub" when its commands conflict with better "git-extras" commands
#

command -v hub > /dev/null || return

hub() {
	case "$1" in
		alias)
			command git "$@"
			;;
		*)
			command hub "$@"
			;;
	esac
}
