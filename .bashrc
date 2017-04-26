# shellcheck shell=bash

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Bash options
shopt -s checkwinsize # automatically adjust window size
shopt -s cdspell      # correct spelling mistakes when using cd
shopt -s dirspell     # correct spelling mistakes in directories
shopt -s globstar     # enable recursive glob matching

# Set up system path
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/go/bin:$HOME/gocode/bin:$HOME/.cargo/bin:$HOME/.yarn-global/bin:$HOME/.gem/ruby/2.3.0/bin:$HOME/.config/composer/vendor/bin:$PATH"

# System Environment Variables
RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export GOPATH=$HOME/gocode
export PREFIX=$HOME/.yarn-global
export CARGO_HOME=$HOME/.cargo
export RUST_SRC_PATH

# Set EDITOR and PAGER
export EDITOR=vim
export PAGER=less
export TERM=xterm-256color
export COLORTERM=tmux-256color

# Fix tiny QT windows on 4k monitor
[[ $(uname -n) == 'archlinux' ]] && export QT_AUTO_SCREEN_SCALE_FACTOR=2

# Source all completions
# shellcheck disable=SC1090
{
    for completion in ~/.completions/*; do
        . "$completion"
    done
    for completion in /etc/bash_completion.d/*; do
        . "$completion"
    done
}

# Format Prompt
# user ~/current/working/dir (repository) DOCKER_MACHINE_NAME $

NC='\[\e[m\]'
BOLD='\[\e[1m\]'
INV='\[\e[7m\]'
GREEN='\[\e[32m\]'
YELLOW='\[\e[33m\]'
PINK='\[\e[35m\]'
RED='\033[0;31m'
BLUE='\[\033[0;34m\]'

__docker_machine_ps1() {
    local format=${1:- [%s]}
    if test "${DOCKER_MACHINE_NAME}"; then
        printf -- "%s %s" "$format" "$DOCKER_MACHINE_NAME"
    fi
}

export PS1="${GREEN}\u ${YELLOW}\w${PINK}\$(__git_ps1)\$(__docker_machine_ps1 \" ${RED}${INV}${BOLD}%s\") ${BLUE}${BOLD}\$${NC} "

#------------------Shell Scripts---------------------#

### Files / Directories
    mcd() {
        mkdir -p "$1"
        cd "$1" || exit
    }
    
    ranger-cd() {
        tempfile="$(mktemp -t tmp.XXXXXX)"
        
        if [[ $(uname) == 'Darwin' ]]; then
            /usr/local/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
        else
            /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
        fi
        
        test -f "$tempfile" &&
        if [ "$(cat "$tempfile")" != "$(echo -n 'pwd')" ]; then
            cd "$(cat "$tempfile")" || exit
        fi
        
        rm -f "$tempfile"
    }
    bind '"\C-o":"ranger-cd\C-m"'

### Docker
    setenv() { eval "$(docker-machine env "$1")"; }

    # Remove either untagged images or a variable number of images (1-9)
    drmi() {
        if [[ $1 = @(u|un) ]]; then
            docker rmi "$(docker images -f dangling=true -q)"
        elif [[ "$1" = [1-9] ]]; then
            docker rmi "$(docker images -q | head -"$1")"
        fi
    }

    # Open an interactive bash session in container N (counting from top)
    dx() {
        docker exec -it "$(docker ps -q -n="$1" | tail -n 1)" /bin/bash -c "export TERM=xterm; exec bash"
    }

### Rust
    rust() {
        if [[ ! -f "$1" || ! "$1" =~ \.rs$ ]]; then
            echo "Enter a valid rust source file."
            return
        fi
        rustc -o /tmp/rustfile "$1" && /tmp/rustfile
    }

### Taskwarrior
    ta() {
        task add "$@" && task sync
    }
    td() {
        task "$1" 'done' && task sync
    }

#---------------------- Aliases-----------------------#

alias bashrc='vim ~/.bashrc'
alias dot='cd ~/.dotfiles'
alias grep='grep --color'
alias restart='source ~/.bashrc'
alias t='task'
alias y='yarn'
alias yu='yarn upgrade-interactive'
alias yug='yarn global upgrade-interactive'

if [[ $(uname) == 'Darwin' ]]; then
    
    alias ls='ls -FHG11'
    
    runcpp() {
        g++ -std=c++11 "$@" -o /tmp/cpprunfile && /tmp/cpprunfile
    }

else
    # Reset caps lock as escape
    alias CAPS='setxkbmap -option caps:escape'
    alias SPOTIFY='spotify --force-device-scale-factor=2 >/dev/null 2>&1 &'
    alias ls='ls -hF1 --color=tty'
    # Verbosely rate the 200 most recently synchronized HTTP servers located in the US,
    # sort them by download rate, and overwrite the file /etc/pacman.d/mirrorlist
    alias pacman-update='sudo reflector --verbose --country "United States" -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'
fi

### Git
alias git='hub'
alias g='git'
alias gb='git branch -a'
alias gs='git status'
alias gss='git status -s'
alias gc='git checkout'
alias gd='git difftool &>/dev/null'
alias gdf='git diff --color | diff-so-fancy'
alias gl='git log --oneline --decorate --all --graph'
alias gca='git commit -a'
alias gf='git fetch'

### Docker
alias d='docker'
alias di='docker images'
alias dm='docker-machine'
alias dc='docker-compose'
