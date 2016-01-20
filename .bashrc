# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Variables
source ~/.git-prompt.sh
export PATH=$PATH:/usr/local/bin

# Set a default prompt: user@host ~/current/working/dir (repository)
 export PS1='\[\e[32m\]\u\[\e[m\] \[\e[33m\]\w\[\e[m\]\[\e[35m\]`__git_ps1`\[\e[m\]\n\$ '


# Uncomment to use the terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

#------------------Shell Scripts---------------------#


### Files / Directories
    mcd () {
        mkdir $1
        cd $1
    }

### Docker
    setenv () {
       eval "$(docker-machine env $1)"
    }
    docker-clean () {
        docker rm $(docker ps -aq -f status=exited)
        docker rmi $(docker images -f "dangling=true" -q)
    }

### Git
    gra () {
        git remote add origin https://github.com/dsifford/$1.git
    }

#---------------------- Aliases-----------------------#

### Meta
    alias restart='source ~/.bashrc'
    alias grep='grep --color'
    alias ls='ls -hF1 --color=tty'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
    alias agent='eval `ssh-agent -s`'
    alias bashrc='vim ~/.bashrc'
    alias i3c='vim ~/.i3/config'

### Atom
    alias atom='atom-beta'
    alias apm='apm-beta'

### Git
    alias g='git'
    alias gs='git status'
    alias gss='git status -s'
    alias gc='git checkout'
    alias gd='git difftool'
    alias gl='git log --oneline --decorate --all --graph'
    alias gca='git commit -a'
    alias gp='git push'
    alias gf='git fetch'

### Docker
    alias d='docker'
    alias di='docker images'
    alias dm='docker-machine'
    alias dc='docker-compose'

    # Remove all containers / images
    alias rma='docker rm $(docker ps -aq)'
    alias rmia='docker rmi $(docker images -q)'

    # Remove all untagged images
    alias drmiu='docker rmi $(docker images | grep "<none>" | awk "{print \$3}")'
    # fix this to use the dangling=true filter -- "docker images -f dangling=true -q"

    alias dpsa='docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
