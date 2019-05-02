# shellcheck shell=bash

# Clean the slate
unalias -a

# Docker
alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'

# Git
alias g='git'
alias git='hub'
alias gs='git status | less'
alias gf='git f'

# Misc
alias dotfiles='cd $DOTFILES'
alias fzf='fzf-tmux'
alias grep='grep --color'
alias info='info --vi-keys'
alias posix-utils='apropos -s 1p .'
alias t='task'
alias tmux='command tmux -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'
alias vimrc='vim "$XDG_CONFIG_HOME/nvim/init.vim"'
alias y='yarn'

command -v rg > /dev/null \
	&& alias grep='rg'

command -v nvim > /dev/null \
	&& alias vim='nvim'

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
fi
