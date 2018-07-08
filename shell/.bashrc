# shellcheck shell=bash disable=SC1090

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Bash options
shopt -s cdspell      # correct spelling mistakes when using cd
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s dirspell     # correct spelling mistakes in directories
shopt -s globstar     # enable recursive glob matching
shopt -s nullglob     # expand non-matching globs to a null string

# Vendor sources
sources=(
    /usr/local/share/bash-completion/bash_completion
    /usr/local/opt/fzf/shell/*.bash
    /usr/share/fzf/*.bash
)

for f in ~/.bashrc.d/* "${sources[@]}"; do
    [[ -f $f ]] && . "$f"
done
unset f sources
