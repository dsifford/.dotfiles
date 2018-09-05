# shellcheck shell=bash
#
# Opens Ranger and on exit, cd into the last directory that Ranger was in.
#

if command -v ranger > /dev/null; then

    ranger-cd() {
        declare exit_dir
        exit_dir="$(mktemp -t ranger-cd.XXXXXX)"
        ranger --choosedir="$exit_dir" "$(pwd)"
        cd "$(cat "$exit_dir")" && rm "$exit_dir" || return
    }

    # <C-o> launches ranger-cd
    bind -x '"\C-o": "ranger-cd"'
    # FIXME: temp fix for osx since above doesn't work for whatever reason
    bind -x '"\C-p": "ranger-cd"'

fi
