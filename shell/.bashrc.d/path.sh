# shellcheck shell=bash

declare newpath
declare -a path=(
    ~/.cargo/bin
    ~/.local/bin
    ~/.local/share/npm/bin
    ~/gocode/bin
    /usr/local/opt/coreutils/libexec/gnubin
    /usr/local/bin
    /usr/local/sbin
    /usr/local/go/bin
)

mapfile -t path < <(
    cat \
        <(printf '%s\n' "${path[@]}") \
        <(echo "$PATH" | tr ':' '\n') \
        <(getconf PATH | tr ':' '\n'))

while read -r p; do
    [ ! -d "$p" ] && continue
    newpath="${newpath:+$newpath:}$p"
done < <(awk '!x[$0]++' < <(printf '%s\n' "${path[@]}"))

PATH="$newpath"
unset path p newpath
