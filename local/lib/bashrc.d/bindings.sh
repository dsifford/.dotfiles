# shellcheck shell=bash disable=SC2016

# <C-p> = cd using fzf
if command -v fzf > /dev/null; then
	bind '"\C-p": "`__fzf_cd__`\n"'
fi

# <C-o> = opens Ranger and on exit, cd into the last directory that Ranger was in.
if command -v ranger > /dev/null; then
	# fixes <C-o> on mac os
	stty discard undef
	ranger-cd() {
		declare exit_dir
		exit_dir="$(mktemp -t ranger-cd.XXXXXX)"
		ranger --choosedir="$exit_dir" "$(pwd)"
		cd "$(cat "$exit_dir")" && rm "$exit_dir"
	}
	bind '"\C-o": "ranger-cd\n"'
fi
