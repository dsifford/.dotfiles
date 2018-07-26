# shellcheck shell=bash disable=2155
unset PREFIX
unset NPM_CONFIG_PREFIX

export EDITOR=nvim
export LESSHISTFILE='-'
export PAGER=less

export DOTFILES=~/.dotfiles

# XDG Base Directory Specification
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

export ATOM_HOME="$XDG_DATA_HOME"/atom
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export HISTFILE="$XDG_DATA_HOME"/bash/history
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
export MANIFOLD_DIR=~/.local/bin
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export PIPSI_HOME="$XDG_DATA_HOME"/pipsi
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export PYLINTRC="$XDG_CONFIG_HOME"/pylint/pylintrc
export PYTHONUSERBASE=~/.local
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export STACK_ROOT="$XDG_DATA_HOME"/stack
export TASKRC="$XDG_CONFIG_HOME"/task/taskrc
export UNCRUSTIFY_CONFIG="$XDG_CONFIG_HOME"/uncrustify/uncrustify.cfg
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export npm_config_devdir="$XDG_CACHE_HOME"/node-gyp

# fzf
if command -v fzf >/dev/null; then
    # use ripgrep instead for better speed and ignored file support
    export FZF_DEFAULT_COMMAND='rg --files . | sort'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='--height 40% --reverse'
    [ -n "$TMUX" ] && {
        export FZF_TMUX=1
    }
fi

# rustc
if command -v rustc >/dev/null; then
    RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
    export RUST_SRC_PATH
fi

if [[ $(uname) == Darwin ]]; then
    unset MANPATH
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/local/opt/gnu-getopt/share/man:$(manpath)"
    export XDG_RUNTIME_DIR="$TMPDIR"
    export MANPATH
else
    # Fix tiny QT windows on 4k monitor
    export QT_AUTO_SCREEN_SCALE_FACTOR=2
    # Fix for deprecated gvfs-trash call
    export ELECTRON_TRASH=gio
fi
