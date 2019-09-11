# shellcheck shell=bash disable=SC1090
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Bash options (see: https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html )
shopt -s cdspell         # correct spelling mistakes when using cd
shopt -s checkwinsize    # check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s dirspell        # correct spelling mistakes in directories
shopt -s globasciiranges # range expressions used in pattern matching behave as if in the traditional C locale when performing comparisons
shopt -s globstar        # enable recursive glob matching
shopt -s nullglob        # expand non-matching globs to a null string

# Vendor sources
sources=(
	~/.local/lib/bashrc.d/**/*.sh
	/usr/local/share/bash-completion/bash_completion
	/usr/local/opt/fzf/shell/*.bash
	/usr/share/fzf/*.bash
)

for f in "${sources[@]}"; do
	[[ -f $f ]] && . "$f"
done
unset f sources
