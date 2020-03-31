# shellcheck shell=bash
#
# Better "npm-check" command utilizing fzf without any other dependencies.
#

command -v fzf > /dev/null || return
command -v npm > /dev/null || return

npmc() {
	declare line version
	declare -a prod dev data
	while read -r line; do
		IFS=' ' read -r -a data <<< "$line"
		version=$(
			sort -Vr < <(printf '%s\n' "${data[1]}" "${data[2]}" "${data[3]}") | head -n 1
		)
		if [[ ${data[5]} == 'dependencies' ]]; then
			prod+=("${data[0]}@$version")
		else
			prod+=("${data[0]}@$version")
		fi
	done < <(npm --color=always outdated --long \
		| fzf --ansi --header-lines 1 -m --nth 1)

	printf '%s\n' "${prod[@]}" | xargs --verbose --no-run-if-empty npm install
	printf '%s\n' "${dev[@]}" | xargs --verbose --no-run-if-empty npm install -D
}

npmcg() {
	npm --color=always -g outdated \
		| fzf --ansi --header-lines 1 -m --nth 1 \
		| awk '{ print $1 }' \
		| xargs --verbose --no-run-if-empty -I % \
			npm -g install %
}
