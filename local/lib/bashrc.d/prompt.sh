# shellcheck shell=bash disable=SC1090

[[ -f $XDG_DATA_HOME/bash-completion/completions/git-prompt ]] &&
	. "$XDG_DATA_HOME"/bash-completion/completions/git-prompt

color() {
	declare reset='\[\e[0m\]'
	declare clr='\[\e[0'
	while test $# -gt 1; do
		case "$1" in
			bold)
				clr+=';1'
				shift;;
			underline)
				clr+=';4'
				shift;;
			invert)
				clr+=';7'
				shift;;
			black)
				clr+=';30'
				shift;;
			red)
				clr+=';31'
				shift;;
			green)
				clr+=';32'
				shift;;
			yellow)
				clr+=';33'
				shift;;
			blue)
				clr+=';34'
				shift;;
			magenta)
				clr+=';35'
				shift;;
			cyan)
				clr+=';36'
				shift;;
			white)
				clr+=';37'
				shift;;
			*)
				shift;;
		esac
	done
	clr+='m\]'
	printf "%s%s%s" "$clr" "$1" "$reset"
}

__bash_prompt_command() {
	PROMPT_GIT="$(__git_ps1 "(%s)")"
}

ps1=(
	"$(color green '\u')"                                     # User
	"$(color yellow '\w')"                                    # Working directory
	"$(color magenta "\${PROMPT_GIT}")"                       # Git repo info
	"$(color bold invert red "\${DOCKER_MACHINE_NAME}")\\n"   # Docker Machine info + line break
	"$(color bold blue '\$')"                                 # `$` (non-root), `#` (root)
	"$(color '')"                                             # Reset color
)

export PROMPT_COMMAND=__bash_prompt_command
export PROMPT_DIRTRIM=3                                       # Trim dirs at 3 levels
export PROMPT_GIT=''
export PS1="${ps1[*]}"
unset ps1 color
