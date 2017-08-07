# shellcheck shell=bash disable=SC1090,SC1091

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Bash options
shopt -s cdspell      # correct spelling mistakes when using cd
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s dirspell     # correct spelling mistakes in directories
shopt -s globstar     # enable recursive glob matching

export CARGO_HOME=~/.cargo
export TERM=tmux-256color
export COLORTERM=tmux-256color
export EDITOR=vim
export GOPATH=~/gocode
export LESSHISTFILE='-'
export PAGER=less
export PREFIX=~/.yarn-global
export RUST_SRC_PATH

# Set up system path
. ~/.shell/.path.sh

RUST_SRC_PATH="$(rustc --print sysroot )/lib/rustlib/src/rust/src"

# Fix tiny QT windows on 4k monitor
[[ $(uname -n) == 'archlinux' ]] && export QT_AUTO_SCREEN_SCALE_FACTOR=2

# Source bash-completion on mac
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Source all completions
for completion in ~/.shell/completions/* /etc/bash_completion.d/*; do
    [ -f "$completion" ] && . "$completion"
done

# Set up terminal prompt
. ~/.shell/.prompt.sh

# Import functions
. ~/.shell/.functions.sh

# Import aliases
. ~/.shell/.aliases.sh
