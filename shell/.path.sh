# shellcheck shell=bash

__parse_path() {
    local IFS i current_path system_default

    IFS=':' read -ra current_path <<< "$PATH"
    IFS=':' read -ra system_default <<< "$( getconf PATH )"

    local path=(
        ~/bin
        ~/.yarn-global/bin
        ~/.cargo/bin
        ~/.local/bin
        /usr/local/bin
        /usr/local/sbin
        /usr/local/go/bin
        ~/gocode/bin
    )

    local deduped_current_path=()
    for i in "${current_path[@]}"; do
        for j in "${path[@]}"; do
            if [[ "$j" == "$i" ]]; then
                continue 2
            fi
        done
        for j in "${system_default[@]}"; do
            if [[ "$j" == "$i" ]]; then
                continue 2
            fi
        done
        deduped_current_path+=( "$i" )
    done
    echo "${path[*]} ${deduped_current_path[*]} ${system_default[*]}:" | tr ' ' ':'
}
PATH="$(__parse_path)"
export PATH
