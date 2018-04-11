#!/usr/bin/env bash

set -e

completions_dir="${XDG_DATA_HOME:?XDG_DATA_HOME must be defined}/bash-completion/completions"
mkdir -p "$completions_dir"

# install generated completions
command -v rustup >/dev/null \
    && rustup completions bash >"$completions_dir"/rustup
command -v npm >/dev/null \
    && npm completion >"$completions_dir"/npm
command -v doctl >/dev/null \
    && doctl completion bash >"$completions_dir"/doctl
command -v pandoc >/dev/null \
    && pandoc --bash-completion >"$completions_dir"/pandoc

if ! command -v wget >/dev/null; then
    echo '[WARN] wget is not installed. Skipping plugin update...'
    exit 1
fi

# FIXME: add way to change name so bash-completion can find all of these
declare -A completion_sources=(
    [cargo]='https://raw.githubusercontent.com/rust-lang/cargo/master/src/etc/cargo.bashcomp.sh'
    ['docker-compose']='https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose'
    [docker]='https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker'
    ['docker-machine']='https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine.bash'
    [git]='https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'
    ['git-prompt']='https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh'
    [hub]='https://raw.githubusercontent.com/github/hub/master/etc/hub.bash_completion.sh'
    [task]='https://raw.githubusercontent.com/GothenburgBitFactory/taskwarrior/master/scripts/bash/task.sh'
    [yarn]='https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash'
)

# printf '%s\n' "${completion_sources[@]}" | xargs -n 1 -P 0 -I{} wget -q --show-progress -N -P "$completions_dir" '{}'

parallel --link \
    wget -q -N -O "$completions_dir"/'{1}' '{2}' \
    ::: "${!completion_sources[@]}" \
    ::: "${completion_sources[@]}"
