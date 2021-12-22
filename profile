# shellcheck shell=sh
#
# ~/.profile
#
unset LC_ALL
unset NPM_CONFIG_PREFIX
unset PREFIX

export LANG=en_US.UTF-8
export LC_COLLATE=C

export BROWSER=firefox-developer-edition
export EDITOR=vim
export PAGER=less

export DOTFILES=~/.dotfiles

# XDG Base Directory Specification
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

export ATOM_HOME=$XDG_DATA_HOME/atom
export AWS_CLI_HISTORY_FILE=$XDG_DATA_HOME/aws/history
export AWS_CONFIG_FILE=$XDG_CONFIG_HOME/aws/config
export AWS_CREDENTIALS_FILE=$XDG_CONFIG_HOME/aws/credentials
export AWS_SHARED_CREDENTIALS_FILE=$XDG_CONFIG_HOME/aws/shared-credentials
export AWS_WEB_IDENTITY_TOKEN_FILE=$XDG_CONFIG_HOME/aws/token
export BAT_THEME=dracula
export CARGO_HOME=$XDG_DATA_HOME/cargo
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker
export GNUPGHOME=$XDG_CONFIG_HOME/gnupg
export GOPATH=$XDG_DATA_HOME/go
export HISTFILE=$XDG_DATA_HOME/bash/history
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
export LESSCHARSET=utf-8
export LESSHISTFILE=-
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export MACHINE_STORAGE_PATH=$XDG_DATA_HOME/docker-machine
export MANIFOLD_DIR=~/.local/bin
export NODE_OPTIONS=--experimental-repl-await
export NODE_REPL_HISTORY=
export NODE_REPL_MODE=strict
export NPM_CONFIG_GLOBALCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NPM_CONFIG_USERCONFIG=$XDG_DATA_HOME/npm/npmrc
export PIPX_HOME=$XDG_DATA_HOME/pipx
export PYLINTHOME=$XDG_CACHE_HOME/pylint
export PYLINTRC=$XDG_CONFIG_HOME/pylint/pylintrc
export PYTHONUSERBASE=~/.local
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/config
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export SSB_HOME=$XDG_DATA_HOME/zoom
export STACK_ROOT=$XDG_DATA_HOME/stack
export TASKDATA=$XDG_DATA_HOME/task
export TASKRC=$XDG_CONFIG_HOME/task/taskrc
export TF_CLI_CONFIG_FILE=$XDG_DATA_HOME/terraform/config.tf
export TMUX_PLUGIN_MANAGER_PATH=$XDG_DATA_HOME/tmux/plugins
export UNCRUSTIFY_CONFIG=$XDG_CONFIG_HOME/uncrustify/uncrustify.cfg
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XINITRC=$XDG_CONFIG_HOME/X11/xinitrc
export npm_config_cache=$XDG_CACHE_HOME/npm
export npm_config_devdir=$XDG_CACHE_HOME/node-gyp

# fzf
if command -v fzf > /dev/null; then
	export FZF_DEFAULT_OPTS='
		--height 40%
		--reverse
		--bind=ctrl-a:toggle-all
		--bind=ctrl-alt-j:preview-down
		--bind=ctrl-alt-k:preview-up
		--bind=ctrl-d:preview-page-down
		--bind=ctrl-u:preview-page-up
        --bind=alt-bs:clear-query
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
    [ -n "$TMUX" ] && export FZF_TMUX=1
fi

if [ -r "$XDG_CONFIG_HOME/Bitwarden CLI/session.sh" ]; then
    # shellcheck disable=SC1090
    . "$XDG_CONFIG_HOME/Bitwarden CLI/session.sh"
fi

if command -v nvim > /dev/null; then
	export EDITOR=nvim
    export MANPAGER='nvim +Man!'
fi

# rustc
if command -v rustc > /dev/null; then
	RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
	export RUST_SRC_PATH
fi

if [ "$(uname)" = Darwin ]; then
	unset MANPATH
	# FIXME: This is broken now after brew updated the locations of gnu manpages.
	MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/local/opt/gnu-getopt/share/man:$(manpath)"
	export MANPATH

	export MANPAGER='less'
    export BROWSER=open
	export CPPFLAGS="-I/usr/local/opt/openssl/include"
	export LDFLAGS="-L/usr/local/opt/openssl/lib"
	export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
	export XDG_RUNTIME_DIR="$TMPDIR"
else
	# Fix for deprecated gvfs-trash call
	export ELECTRON_TRASH=gio
fi

# vim: set ft=sh:
