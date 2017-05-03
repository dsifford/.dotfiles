# shellcheck shell=bash disable=SC1090,SC1091

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Bash options
shopt -s cdspell      # correct spelling mistakes when using cd
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s dirspell     # correct spelling mistakes in directories
shopt -s globstar     # enable recursive glob matching

# System Environment Variables
RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export EDITOR=vim
export PAGER=less
export TERM=xterm-256color
export COLORTERM=tmux-256color
export GOPATH=~/gocode
export PREFIX=~/.yarn-global
export CARGO_HOME=~/.cargo
export RUST_SRC_PATH

# Fix tiny QT windows on 4k monitor
[[ $(uname -n) == 'archlinux' ]] && export QT_AUTO_SCREEN_SCALE_FACTOR=2

# Source bash-completion on mac
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Source all completions
for completion in ~/.shell/completions/* /etc/bash_completion.d/*; do
    [ -f "$completion" ] && . "$completion"
done

# Set up system path
. ~/.shell/.path.sh

# Set up terminal prompt
. ~/.shell/.prompt.sh

# Import functions
. ~/.shell/.functions.sh

# Import aliases
. ~/.shell/.aliases.sh
