# shellcheck shell=bash disable=2155
unset PREFIX
unset NPM_CONFIG_PREFIX

export EDITOR=vim
export LESSHISTFILE='-'
export PAGER=less
export LC_ALL=C

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
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
export MANIFOLD_DIR=~/.local/bin
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PIPX_HOME="$XDG_DATA_HOME"/pipx
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export PYLINTRC="$XDG_CONFIG_HOME"/pylint/pylintrc
export PYTHONUSERBASE=~/.local
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export STACK_ROOT="$XDG_DATA_HOME"/stack
export TASKRC="$XDG_CONFIG_HOME"/task/taskrc
export UNCRUSTIFY_CONFIG="$XDG_CONFIG_HOME"/uncrustify/uncrustify.cfg
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME"/nvidia/GLCache
export npm_config_devdir="$XDG_CACHE_HOME"/node-gyp

# fzf
if command -v fzf > /dev/null; then
	# use ripgrep instead for better speed and ignored file support
	export FZF_DEFAULT_OPTS='
		--height 40%
		--reverse
		--bind=ctrl-a:toggle-all
		--bind=ctrl-alt-j:preview-down
		--bind=ctrl-alt-k:preview-up
		--bind=ctrl-d:preview-page-down
		--bind=ctrl-u:preview-page-up
		--color fg:#F8F8F2
		--color fg+:#F8F8F2
		--color bg:-1
		--color bg+:-1
		--color hl:#50FA7B
		--color hl+:#FFB86C
		--color info:#BD93F9
		--color prompt:#50FA7B
		--color pointer:#FF79C6
		--color marker:#FF5555
		--color spinner:#8BE9FD
		--color header:#8BE9FD
	'
	export FZF_TMUX=$([[ -n $TMUX ]] && echo 1 || echo 0)
fi

if command -v nvim > /dev/null; then
	export EDITOR=nvim
	export MANPAGER='nvim -c "set ft=man" -'
fi

# rustc
if command -v rustc > /dev/null; then
	RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
	export RUST_SRC_PATH
fi

if [[ $(uname) == Darwin ]]; then
	unset MANPATH
	# FIXME: This is broken now after brew updated the locations of gnu manpages.
	MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/local/opt/gnu-getopt/share/man:$(manpath)"
	export MANPATH
	export XDG_RUNTIME_DIR="$TMPDIR"
	export CPPFLAGS="-I/usr/local/opt/openssl/include"
	export LDFLAGS="-L/usr/local/opt/openssl/lib"
	export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
else
	# Fix tiny QT windows on 4k monitor
	export QT_AUTO_SCREEN_SCALE_FACTOR=2
	# Fix for deprecated gvfs-trash call
	export ELECTRON_TRASH=gio
fi
