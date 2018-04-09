#!/usr/bin/env bash

set -e

if ! command -v wget >/dev/null; then
    echo '[WARN] wget is not installed. Skipping plugin update...'
    exit 1
fi

completions_dir="${XDG_DATA_HOME:?XDG_DATA_HOME must be defined}/bash-completions/completions"

mkdir -p "$completions_dir"

declare -a completion_sources=(
    'https://raw.githubusercontent.com/rust-lang/cargo/master/src/etc/cargo.bashcomp.sh'
    'https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose'
    'https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine.bash'
    'https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker'
    'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh'
    'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'
    'https://raw.githubusercontent.com/github/hub/master/etc/hub.bash_completion.sh'
    'https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash'
)

printf '%s\n' "${completion_sources[@]}" | xargs -n 1 -P 0 -I{} wget -q --show-progress -N -P "$completions_dir" '{}'
