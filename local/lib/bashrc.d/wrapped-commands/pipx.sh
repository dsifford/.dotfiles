# shellcheck shell=bash
#
# Wrap pipx so that packages list is updated whenever install
# or uninstall is invoked.
#

command -v pipx > /dev/null || return

pipx() (
	set -e
	shopt -s nullglob failglob

	declare PIPX_HOME="${PIPX_HOME?:PIPX_HOME env var not set}"
	declare DOTFILES="${DOTFILES?:DOTFILES env var not set}"
	declare package

	case "$1" in
		install | uninstall)
			command pipx "$@"
			;;
		*)
			command pipx "$@"
			return
			;;
	esac

	{
		echo '#'
		echo '# THIS IS A GENERATED FILE. DO NOT EDIT DIRECTLY.'
		echo '#'
		echo '- pipx:'

		for package in "$PIPX_HOME"/venvs/*; do
			echo "  - $(basename "$package")"
		done
	} > "$DOTFILES"/.lib/config/generated/packages.pipx.yml
)
