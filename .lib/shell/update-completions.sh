#!/usr/bin/env bash

set -e

if ! command -v wget > /dev/null; then
    echo '[WARN] wget is not installed. Skipping plugin update...'
    exit 1
fi

completions_dir=~/.dotfiles/shell/completions
[ -d "$completions_dir" ] || { echo 'completions directory does not exit'; exit 1; }

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

declare -a skipped=(
    aliases
    doctl.sh
    npm.sh
    rustup.sh
)

# Prune out old garbage
declare f
for f in "$completions_dir"/*; do
    [[ " ${skipped[*]} " =~ [[:space:]]"$(basename "$f")"[[:space:]] ]] && continue
    for src in "${completion_sources[@]}"; do
        [ "$(basename "$f")" == "$(basename "$src")" ] && continue 2
    done
    echo "$( basename "$f" ) no longer needed. Pruning..."
    rm "$f"
done

# Install each completion from source if needed
declare src
for src in "${completion_sources[@]}"; do
    wget -nc -q --show-progress -P "$completions_dir" "$src"
done

# Install completions using built-in CLI tool if available
command -v rustup >/dev/null && rustup completions bash > "$completions_dir/rustup.sh"
command -v npm >/dev/null && npm completion > "$completions_dir/npm.sh"
command -v doctl >/dev/null && doctl completion bash > "$completions_dir/doctl.sh"

exit 0
