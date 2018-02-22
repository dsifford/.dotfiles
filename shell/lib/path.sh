# shellcheck shell=bash

path_append() {
    declare -p path > /dev/null || exit 1
    declare value="$2"
    declare item

    for item in "${path[@]}"; do
        [ "$item" == "$value" ] && return
    done

    path+=( "$value" )
}

parse_path() {
    declare output
    declare item
    declare -a path=(
        ~/bin
        ~/.yarn-global/bin
        ~/.cargo/bin
        ~/.local/bin
        ~/gocode/bin
        /usr/local/bin
        /usr/local/sbin
        /usr/local/go/bin
    )

    mapfile -d: -t -C path_append -c 1 <<< "${PATH}$( getconf PATH )"

    for item in "${path[@]}"; do
        [[ ! -d "$item" ]] && continue
        output+="$( [ -z "$output" ] && echo -n "$item" || echo -n ":$item" )"
    done

    echo "$output"
}

PATH="$(parse_path)"
export PATH

unset parse_path path_append
