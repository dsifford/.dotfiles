# shellcheck shell=bash disable=SC1090

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Bash options
shopt -s cdspell      # correct spelling mistakes when using cd
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s dirspell     # correct spelling mistakes in directories
shopt -s globstar     # enable recursive glob matching

# Sources
sources=(
    /etc/bash_completion.d
    /usr/local/share/bash-completion/completions
    /usr/local/etc/bash_completion.d
    /usr/local/opt/fzf/shell/*.bash
    /usr/share/fzf/*.bash
    ~/.dotfiles/shell/completions
    ~/.dotfiles/shell/lib
)
for item in "${sources[@]}"; do
    if [ -f "$item" ]; then
        . "$item"
    elif [ -d "$item" ]; then
        while read -r src; do
            . "$src"
        done < <(find -L "$item" -maxdepth 1 -type f ! -name ".*" | sort -r)
    fi
done
unset sources item src
