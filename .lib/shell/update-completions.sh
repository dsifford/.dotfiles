#!/usr/bin/env bash

set -e

if ! command -v wget >/dev/null; then
	echo '[WARN] wget is not installed. Skipping plugin update...'
	exit 1
fi

completions_dir=~/.dotfiles/shell/completions
[ -d "$completions_dir" ] || {
	echo 'completions directory does not exit'
	exit 1
}

declare -a completion_sources=(
	https://raw.githubusercontent.com/rust-lang/cargo/master/src/etc/cargo.bashcomp.sh
	https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose
	https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine.bash
	https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker
	https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
	https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	https://raw.githubusercontent.com/github/hub/master/etc/hub.bash_completion.sh
	https://raw.githubusercontent.com/GothenburgBitFactory/taskwarrior/master/scripts/bash/task.sh
	https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash
)

# Prune out old garbage
rm -f "$completions_dir"/*

# Install each completion from source if needed
for src in "${completion_sources[@]}"; do
	wget -nc -q -P "$completions_dir" "$src"
done
