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

# Misc
alias reload='source ~/.bashrc'
alias bashrc='vim ~/.bashrc'
alias dot='cd ~/.dotfiles'
alias grep='grep --color'
alias yu='yarn upgrade-interactive'
alias yug='yarn global upgrade-interactive'

### Git
alias git='hub'
alias gb='git branch -a'
alias gs='git status'
alias gss='git status -s'
alias gc='git checkout'
alias gl='git log --oneline --decorate --all --graph'
alias gca='git commit -a'
alias gf='git fetch --prune'

# Macbook
if [[ $(uname) == 'Darwin' ]]; then

    alias ls='ls -FHG11'

    # Quickly compile and run a small C++ program
    runcpp() {
        g++ -std=c++11 "$@" -o /tmp/cpprunfile && /tmp/cpprunfile
    }
fi

# Arch linux machine
if [[ $(uname -n) == 'archlinux' ]]; then
    # Reset caps lock as escape
    alias CAPS='setxkbmap -option caps:escape'
    alias SPOTIFY='spotify --force-device-scale-factor=2 >/dev/null 2>&1 &'
    alias ls='ls -hF1 --color=tty'
    # Verbosely rate the 200 most recently synchronized HTTP servers located in the US,
    # sort them by download rate, and overwrite the file /etc/pacman.d/mirrorlist
    alias pacman-update='sudo reflector --verbose --country "United States" -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'
fi
