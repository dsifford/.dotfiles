# shellcheck shell=bash disable=SC1090

for f in ~/.bashrc.d/functions.d/*; do
    [[ -f $f ]] && . "$f"
done
