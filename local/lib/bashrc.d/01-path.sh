# shellcheck shell=bash

declare newpath
declare -a path=(
    ~/.local/bin
    /usr/local/opt/gnu-getopt/bin
    /usr/local/opt/coreutils/libexec/gnubin
    "$XDG_DATA_HOME"/{cargo,go,npm}/bin
    /usr/local/{bin,sbin}
    /usr/local/go/bin
	~/Library/Python/*/bin
	/usr/local/Cellar/python*/*/Frameworks/**/bin
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