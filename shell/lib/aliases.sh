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
alias git='hub-stub-conflicting-commands'
alias gb='git branch -a'
alias gs='git status'
alias gss='git status -s'
alias gc='git checkout'
alias gl='git log --oneline --decorate --all --graph'
alias gca='git commit -a'
alias gf='git fetch --all --prune'

# Misc
alias reload='source ~/.bashrc'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.dotfiles/vim/.vimrc'
alias dot='cd ~/.dotfiles'
alias grep='grep --color'
alias npmc='npm-check -u'
alias npmcg='npm-check -ug'
alias tmux='TERM=xterm tmux'
alias info='info --vi-keys'

## Always use neovim
alias vim='nvim'

# Coreutils stuff
if ls --version &> /dev/null; then
    alias ls='ls -hF1 --color=tty'
else
    alias ls='ls -FHG11'
fi

# Macbook
if [[ $(uname) == 'Darwin' ]]; then
    alias python='python3'
    alias pip='pip3'
fi

# Arch linux
if [[ $(uname) == 'Linux' ]]; then
    # Verbosely rate the 200 most recently synchronized HTTP servers located in the US,
    # sort them by download rate, and overwrite the file /etc/pacman.d/mirrorlist
    alias pacman-update='sudo reflector --verbose --country "United States" -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'
    alias p='trizen'
    alias psyu='trizen -Syu'

    # Plex library scan
    alias plex='LD_LIBRARY_PATH=/opt/plexmediaserver /opt/plexmediaserver/Plex\ Media\ Scanner'
fi
