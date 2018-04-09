# shellcheck shell=bash disable=SC1090

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Bash options
shopt -s cdspell      # correct spelling mistakes when using cd
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s dirspell     # correct spelling mistakes in directories
shopt -s globstar     # enable recursive glob matching

. ~/.bashrc.d/environment.sh
. ~/.bashrc.d/path.sh

# Vendor sources
sources=(
    /usr/local/share/bash-completion/bash_completion
    /usr/local/opt/fzf/shell/*.bash
    /usr/share/fzf/*.bash
)
for item in "${sources[@]}"; do
    if [ -f "$item" ]; then
        . "$item"
    fi
done
unset sources item src

. ~/.bashrc.d/functions.sh
. ~/.bashrc.d/aliases.sh
. ~/.bashrc.d/prompt.sh
