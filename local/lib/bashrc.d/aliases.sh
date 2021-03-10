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
alias ..='cd ..'
alias ssh='TERM=xterm-256color ssh'
alias dotfiles='cd $DOTFILES'
alias fzf='fzf-tmux'
alias info='info --vi-keys'
alias t='task'
alias tmux='command tmux -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'
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
