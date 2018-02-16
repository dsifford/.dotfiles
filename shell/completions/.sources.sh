#!/usr/bin/env bash

get_completions() {
    local completions_dir src

    # Map of aliases to add to certain completions
    local -A aliases=(
        [docker]='complete -F _docker d'
        [docker-compose]='complete -F _docker_compose dc'
        [docker-machine]='complete -F _docker_machine dm'
        [git]='__git_complete g __git_main'
        [task]='complete -o nospace -F _task t'
        [yarn]='complete -F _yarn y'
    )

    # Map of completions to install from source
    local -A completion_sources=(
        [cargo]='https://raw.githubusercontent.com/rust-lang/cargo/master/src/etc/cargo.bashcomp.sh'
        [docker-compose]='https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose'
        [docker-machine]='https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine.bash'
        [exercism]='http://cli.exercism.io/exercism_completion.bash'
        [docker]='https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker'
        [git-prompt]='https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh'
        [git]='https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'
        [hub]='https://raw.githubusercontent.com/github/hub/master/etc/hub.bash_completion.sh'
        [task]='https://raw.githubusercontent.com/GothenburgBitFactory/taskwarrior/master/scripts/bash/task.sh'
        [yarn]='https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash'
    )

    completions_dir="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

    # Install each completion from source
    for src in "${!completion_sources[@]}"; do
        echo Installing "$src" completions
        curl -# -o "$completions_dir/$src.sh" "${completion_sources[$src]}"
    done

    # Add aliases
    for src in "${!aliases[@]}"; do
        printf "%s\n" "${aliases[$src]}" >> "$completions_dir/$src.sh"
    done

    # Install completions using built-in CLI tool if available
    command -v rustup >/dev/null && rustup completions bash > "$completions_dir/rustup.sh"
    command -v npm >/dev/null && npm completion > "$completions_dir/npm.sh"
    command -v doctl >/dev/null && doctl completion bash > "$completions_dir/doctl.sh"
}

get_completions
