# shellcheck shell=bash

__parse_path() {
    local IFS i current_path system_default cleaned_path
    local -A pathmap
    local patharr=()

    IFS=':' read -ra current_path <<< "$PATH"
    IFS=':' read -ra system_default <<< "$( getconf PATH )"

    local my_path=(
        ~/bin
        ~/.yarn-global/bin
        ~/.cargo/bin
        /usr/local/bin
        /usr/local/sbin
        /usr/local/go/bin
        ~/gocode/bin
        "${current_path[@]}"
        "${system_default[@]}"
    )

    # Dedupe path
    for i in "${my_path[@]}"; do
        # Uncomment below to remove single elements from path
        # if [[ $i == *ruby* ]]; then continue; fi
        [[ ! ${pathmap[$i]} ]] && pathmap[$i]=1 && patharr+=( "$i:" )
    done

    # Concat to string
    cleaned_path="${patharr[*]}"

    # Remove whitespace
    echo "${cleaned_path// /}"
}
path="$(__parse_path)"
export PATH="$path"
