# shellcheck shell=bash disable=SC1090

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Bash options
shopt -s cdspell      # correct spelling mistakes when using cd
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s dirspell     # correct spelling mistakes in directories
shopt -s globstar     # enable recursive glob matching

RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export CARGO_HOME=~/.cargo
export COLORTERM=screen-256color
export EDITOR=nvim
export GOPATH=~/gocode
export LESSHISTFILE='-'
export NPM_CONFIG_PREFIX=~/.yarn-global
export PAGER=less
export PREFIX=~/.yarn-global
export RUST_SRC_PATH
export TERM=screen-256color

if [[ $(uname) == Linux ]]; then
    # Fix tiny QT windows on 4k monitor
    export QT_AUTO_SCREEN_SCALE_FACTOR=2
fi

if [[ $(uname) == Darwin ]]; then
    [ -L /usr/local/share/bash-completion/bash_completion ] && . /usr/local/share/bash-completion/bash_completion
    unset MANPATH
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$(manpath)"
    export MANPATH
fi

# Sources
source_dirs=(
    /etc/bash_completion.d
    /usr/local/share/bash-completion/completions
    /usr/local/etc/bash_completion.d
    ~/.dotfiles/shell/completions
    ~/.dotfiles/shell/lib
)
for item in "${source_dirs[@]}"; do
    [ ! -d "$item" ] && continue
    while read -r __file; do
        . "$__file"
    done < <(find -L "$item" -maxdepth 1 -type f ! -name ".*" | sort -r)
done
unset source_dirs item __file
