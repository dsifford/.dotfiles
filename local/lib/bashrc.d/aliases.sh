# shellcheck shell=bash

# Clean the slate
unalias -a

# Package aliases
alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'
alias g='git'
alias t='task'
alias y='yarn'

# Git
alias git='hub'
alias gs='git status'
alias gf='git f'

# Misc
alias bashrc='vim ~/.bashrc'
alias dot='cd ~/.dotfiles'
alias fzf='fzf-tmux'
alias grep='grep --color'
alias info='info --vi-keys'
alias posix-utils='apropos -s 1p .'
alias reload='source ~/.bashrc'
alias svn='command svn --config-dir "$XDG_CONFIG_HOME"/subversion'
alias tmux='command tmux -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'
alias vimrc='vim ~/.dotfiles/vim/.vimrc'

## Always use neovim
command -v nvim > /dev/null && alias vim='nvim'

command -v nvidia-settings > /dev/null \
	&& alias nvidia-settings='command nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'

# Coreutils stuff
if ls --version &> /dev/null; then
	alias ls='ls -hF1 --group-directories-first --color=tty'
else
	alias ls='ls -FHG11'
fi

if [[ $(uname) != 'Darwin' ]]; then
	# Verbosely rate the 200 most recently synchronized HTTP servers located in the US,
	# sort them by download rate, and overwrite the file /etc/pacman.d/mirrorlist
	alias pacman-update='sudo reflector --verbose --country "United States" -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'
	alias p='trizen'
	alias psyu='trizen -Syu --devel'
	alias psyun='trizen -Syu --noconfirm --devel'
fi
