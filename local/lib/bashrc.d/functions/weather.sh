# shellcheck shell=bash
#
# Prints the weather forecast from wttr.in
#

weather() {
    declare request="https://wttr.in/$1"
	declare args='?'
	args+='F' # suppress 'follow on twitter' line
	args+='q' # suppress useless text
    [[ $COLUMNS -lt 125 ]] && args+='n'
    curl --compressed "$request$args"
}
