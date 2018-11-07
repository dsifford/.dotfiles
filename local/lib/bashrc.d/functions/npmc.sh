# shellcheck shell=bash
#
# Better "npm-check" command utilizing fzf without any other dependencies.
#

if command -v fzf > /dev/null; then

	npmc() {
		npm --color=always outdated --long \
			| fzf --ansi --header-lines 1 -m --nth 1 \
			| awk '{ if ($6=="devDependencies") print "-D "$1"@"$4; else print $1"@"$4 }' \
			| xargs --verbose --no-run-if-empty -L 1 \
			npm install
	}

	npmcg() {
		npm --color=always -g outdated \
			| fzf --ansi --header-lines 1 -m --nth 1 \
			| awk '{ print $1"@"$4 }' \
			| xargs --verbose --no-run-if-empty -I % \
			npm -g install %
	}

fi
