# shellcheck shell=bash disable=SC1090

for f in ~/.bashrc.d/wrapped-commands.d/*; do
    [[ -f $f ]] && . "$f"
done
unset f
