# shellcheck shell=bash

# Remove either untagged images or a variable number of images (1-9)
drmi() {
    if [[ $1 = @(u|un) ]]; then
        docker rmi "$(docker images -f dangling=true -q)"
    elif [[ "$1" = [1-9] ]]; then
        docker rmi "$(docker images -q | head -"$1")"
    fi
}

# Open an interactive bash session in container N (counting from top)
dx() {
    docker exec -it "$(docker ps -q -n="$1" | tail -n 1)" /bin/bash -c "export TERM=xterm; exec bash"
}

# Make a directory and immediately cd into it
mcd() {
    mkdir -p "$1"
    cd "$1" || exit
}

# Change directory to the directory that currently in when exiting ranger
# <C-o> opens ranger
ranger-cd() {
    tempfile="$(mktemp -t tmp.XXXXXX)"

    if [[ $(uname) == 'Darwin' ]]; then
        /usr/local/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    else
        /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    fi

    test -f "$tempfile" &&
    if [ "$(cat "$tempfile")" != "$(echo -n 'pwd')" ]; then
        cd "$(cat "$tempfile")" || exit
    fi

    rm -f "$tempfile"
}
bind '"\C-o":"ranger-cd\C-m"'

### Compile and run a simple rust program
rust() {
    if [[ ! -f "$1" || ! "$1" =~ \.rs$ ]]; then
        echo "Enter a valid rust source file."
        return
    fi
    rustc -o /tmp/rustfile "$1" && /tmp/rustfile
}

# Set the docker machine environment.
# `setenv -u` will unset back to normal
setenv() { eval "$(docker-machine env "$1")"; }
