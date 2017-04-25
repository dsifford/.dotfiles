#!/usr/bin/env bash

get_completions() {
    local completions_dir
    local src
    local -A completion_sources=(
        [cargo]='https://raw.githubusercontent.com/rust-lang/cargo/master/src/etc/cargo.bashcomp.sh'
        [docker-compose]='https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose'
        [docker-machine]='https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine.bash'
        [docker]='https://raw.githubusercontent.com/moby/moby/master/contrib/completion/bash/docker'
        [git-prompt]='https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh'
        [git]='https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'
        [hub]='https://raw.githubusercontent.com/github/hub/master/etc/hub.bash_completion.sh'
    )

    completions_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    for src in "${!completion_sources[@]}"; do
        echo Installing "$src" completions
        curl -# -o "$completions_dir/$src.sh" "${completion_sources[$src]}"
    done 

    command -v rustup >/dev/null && rustup completions bash > "$completions_dir/rustup.sh"
}

get_completions