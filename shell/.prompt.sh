# shellcheck shell=bash

NC='\[\e[m\]'
BOLD='\[\e[1m\]'
INV='\[\e[7m\]'
GREEN='\[\e[32m\]'
YELLOW='\[\e[33m\]'
PINK='\[\e[35m\]'
RED='\033[0;31m'
BLUE='\[\033[0;34m\]'

# Show active docker machine name if available
__docker_machine_ps1() {
    local format=${1:- [%s]}
    if test "${DOCKER_MACHINE_NAME}"; then
        printf -- "%s %s" "$format" "$DOCKER_MACHINE_NAME"
    fi
}

PROMPT_DIRTRIM=3 # Trim directory mapping to maximum of three levels upward
PS1="${GREEN}\u ${YELLOW}\w${PINK}\$(__git_ps1)\$(__docker_machine_ps1 \" ${RED}${INV}${BOLD}%s\") ${BLUE}${BOLD}\$${NC} "
