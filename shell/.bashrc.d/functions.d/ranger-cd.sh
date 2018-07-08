# shellcheck shell=bash
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
bind '"\C-o":"ranger-cd\n"'
