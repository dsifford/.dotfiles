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

# Stub out "hub" when its commands conflict with better "git-extras" commands
hub-stub-conflicting-commands() {
    case "$1" in
        alias|fork|pr)
            /usr/bin/env git "$@"
            ;;
        browse)
            # Fix for random error that always shows up but doesn't actually matter
            /usr/bin/env hub "$@" 2>/dev/null
            ;;
        *)
            /usr/bin/env hub "$@"
    esac
}

# Make a directory and immediately cd into it
mcd() {
    mkdir -p "$1"
    cd "$1" || exit
}

# Change directory to the directory that currently in when exiting ranger
# <C-o> opens ranger
ranger-cd() {
    local tempfile
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

# Quickly compile and run a small C++ program
runcpp() {
    [ ! "$1" ] && return
    local tempfile
    tempfile="$(mktemp -t cpprunfile.XXXXXX)"
    g++ -Wall -std=c++11 -g "$1" -o "$tempfile" && "$tempfile"
    rm -f "$tempfile"
}

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
