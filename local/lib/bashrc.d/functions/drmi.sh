# shellcheck shell=bash
#
# Enhanced "docker rmi" that allows selecting images using fzf
#

command -v docker > /dev/null || return
command -v fzf > /dev/null || return

drmi() {
	docker images \
		| fzf --header-lines 1 --nth 1 --multi \
		| awk '/<none>/{ print $3; next }{ print $1":"$2 }' \
		| xargs --verbose --no-run-if-empty docker rmi
}
