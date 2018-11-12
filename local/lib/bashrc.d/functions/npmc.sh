# shellcheck shell=bash
#
# Better "npm-check" command utilizing fzf without any other dependencies.
#

if command -v fzf > /dev/null; then

	npmc() {
		declare pkg
		declare -a prod dev
		while read -r pkg; do
			if [[ $pkg == -P* ]]; then
				prod+=("$pkg")
			else
				dev+=("$pkg")
			fi
		done < <(npm --color=always outdated --long \
			| fzf --ansi --header-lines 1 -m --nth 1 \
			| awk '{ if ($6=="devDependencies") print "-D "$1"@"$4; else print "-P "$1"@"$4 }')

		printf '%s\n' "${prod[@]}" | xargs --verbose --no-run-if-empty npm install
		printf '%s\n' "${dev[@]}" | xargs --verbose --no-run-if-empty npm install
	}

	npmcg() {
		npm --color=always -g outdated \
			| fzf --ansi --header-lines 1 -m --nth 1 \
			| awk '{ print $1"@"$4 }' \
			| xargs --verbose --no-run-if-empty -P 5 -I % \
				npm -g install %
	}

fi
