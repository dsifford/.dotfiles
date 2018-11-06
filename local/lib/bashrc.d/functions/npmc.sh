# shellcheck shell=bash
#
# Better "npm-check" command utilizing fzf without any other dependencies.
#

if command -v fzf > /dev/null; then

	npmc() {
		npm --color=always outdated \
			| fzf --ansi --header-lines 1 -m --nth 1 \
			| awk '{ print $1"@"$4 }' \
			| xargs --verbose --no-run-if-empty --max-args=1 \
			npm install
	}

	npmcg() {
		npm --color=always -g outdated \
			| fzf --ansi --header-lines 1 -m --nth 1 \
			| awk '{ print $1"@"$4 }' \
			| xargs --verbose --no-run-if-empty --max-args=1 \
			npm -g install
	}

fi
