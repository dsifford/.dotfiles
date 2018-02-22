# shellcheck shell=bash

# Remove either untagged images or a variable number of images (1-9)
drmi() {
    if [[ $1 = @(u|un) ]]; then
        docker rmi "$(docker images -f dangling=true -q)"
    elif [[ "$1" = [1-9] ]]; then
        docker rmi "$(docker images -q | head -"$1")"
    fi
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

# Colorize manpages
man() {
    # LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_md=$'\e[01;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[00;47;30m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

## pstree colored output TODO: tweak this so numbers are better represented
if command -v pstree > /dev/null; then
    pstree() {
        command pstree -U "$@" | sed '
            s/[-a-zA-Z]\+/\x1B[32m&\x1B[0m/g
            s/[{}]/\x1B[31m&\x1B[0m/g
            s/[─┬─├─└│]/\x1B[34m&\x1B[0m/g
        '
    }
fi

# Make a directory and immediately cd into it
mcd() {
    mkdir -p "$1"
    cd "$1" || exit
}

# Change directory to the directory that currently in when exiting ranger
# <C-o> opens ranger
ranger-cd() {
    local tempfile
    tempfile="$(mktemp -t ranger-cd.XXXXXX)"
    ranger --choosedir="$tempfile" "$(pwd)"
    if [ "$(cat "$tempfile")" != "$(pwd)" ]; then
        cd "$(cat "$tempfile")" || exit
    fi
    rm -f "$tempfile"
}
bind -x '"\C-o":"ranger-cd"'

# Quickly compile and run a small C++ program
runcpp() {
    [ ! "$1" ] && return
    local tempfile
    tempfile="$(mktemp -t cpprunfile.XXXXXX)"
    g++ -Wall -std=c++11 -g "$1" -o "$tempfile" && "$tempfile"
    rm -f "$tempfile"
}

# Set the docker machine environment.
# `setenv -u` will unset back to normal
setenv() { eval "$(docker-machine env "$1")"; }
