
# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Set up system path
export PATH=$PATH:$HOME/gocode/bin:/usr/local/bin:/usr/local/go/bin

# System Environment Variables
export GOPATH=$HOME/gocode

# Set EDITOR and PAGER
export EDITOR=vim
export PAGER=less
export TERM=tmux-256color
export COLORTERM=tmux-256color

# Fix tiny QT windows on 4k monitor
[[ $(uname -n) == 'desktop' ]] && export QT_DEVICE_PIXEL_RATIO=2

# Source git prompt script
source ~/.git-prompt.sh

# Set a default prompt: user@host ~/current/working/dir (repository)
export PS1='\[\e[32m\]\u\[\e[m\] \[\e[33m\]\w\[\e[m\]\[\e[35m\]`__git_ps1`\[\e[m\]\n '

# Bash options
shopt -s checkwinsize # automatically adjust window size
shopt -s cdspell      # correct spelling mistakes when using cd
shopt -s dirspell     # correct spelling mistakes in directories

#------------------Shell Scripts---------------------#


### Files / Directories
    mcd () {
        mkdir $1
        cd $1
    }
    function ranger-cd {
    	tempfile="$(mktemp -t tmp.XXXXXX)"
	/usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
	test -f "$tempfile" &&
	if [ "$(cat -- "$tempfile")" != "$(echo -n 'pwd')" ]; then
		cd -- "$(cat "$tempfile")"
	fi
	rm -f -- "$tempfile"
    }
    bind '"\C-o":"ranger-cd\C-m"'

### Docker
    setenv () {
       eval "$(docker-machine env $1)"
    }
    docker-clean () {
	CONTAINERS=$(docker ps -aq -f status=exited)
	IMAGES=$(docker images -q -f dangling=true)
	if [[ $CONTAINERS ]]; then
	    docker rm -v $CONTAINERS
	fi
	if [[ $IMAGES ]]; then
	    docker rmi $IMAGES
	fi
    }

    # Remove either untagged images or a variable number of images (1-9)
    drmi () {
	if [[ $1 = @(u|un) ]]; then docker rmi $(docker images -f dangling=true -q)
	elif [[ "$1" = [1-9] ]]; then docker rmi $(docker images -q | head -"$1")
	fi
    }

### Git
    gra () {
        git remote add origin https://github.com/dsifford/$1.git
    }

### Taskwarrior
    t () {
        if [[ ! $@ ]]; then task; else task $@ && task sync; fi
    }
    ta () {
    	task add $* && task sync
    }
    td () {
   	task $1 done && task sync
    }

#---------------------- Aliases-----------------------#

### Meta
    alias restart='source ~/.bashrc'
    alias atom='atom-beta'
    alias apm='apm-beta'
    alias grep='grep --color'
    alias ls='ls -hF1 --color=tty'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
    alias agent='eval `ssh-agent -s`'
    alias bashrc='vim ~/.bashrc'
    alias i3c='if [[ $(uname -n) = "desktop" ]]; then vim ~/.dotfiles/i3/config.desktop; else vim ~/.dotfiles/i3/config.laptop; fi'
    alias i3cm='vim ~/.dotfiles/i3/config.common'
    alias dot='cd ~/.dotfiles'
    alias vimrc='vim ~/.vimrc'

### Arch
    # Verbosely rate the 200 most recently synchronized HTTP servers located in the US, 
    # sort them by download rate, and overwrite the file /etc/pacman.d/mirrorlist
    alias pacman-update='sudo reflector --verbose --country "United States" -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'

### Git
    alias g='git'
    alias gs='git status'
    alias gss='git status -s'
    alias gc='git checkout'
    alias gcm='git commit'
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

    # Better format for "docker ps"
    alias dpsa='docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'

    # Run a juypter container
    alias jp='docker run --rm -it -e GRANT_SUDO=yes --user root -p 8888:8888 -v "$(pwd):/home/jovyan/work" jupyter/scipy-notebook'

