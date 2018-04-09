# shellcheck shell=bash

# XDG Base Directory Specification
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

export EDITOR=nvim
export GOPATH=~/gocode
export LESSHISTFILE='-'
export PAGER=less
export TASKRC="$XDG_CONFIG_HOME/task/taskrc"

# FIXME: Move these things into appropriate XDG directories
export CARGO_HOME=~/.cargo
export NPM_CONFIG_PREFIX=~/.yarn-global
export PREFIX=~/.yarn-global

if [[ $(uname) == Darwin ]]; then
    unset MANPATH
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$(manpath)"
    export MANPATH
else
    # Fix tiny QT windows on 4k monitor
    export QT_AUTO_SCREEN_SCALE_FACTOR=2
    # Fix for deprecated gvfs-trash call
    export ELECTRON_TRASH=gio
fi

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

