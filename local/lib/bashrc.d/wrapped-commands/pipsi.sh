# shellcheck shell=bash
#
# Wrap pipsi so that the install subcommand always installs to the latest
# version of python available in the PATH
#

command -v pipsi > /dev/null || return

pipsi() (
	set -e
	shopt -s nullglob failglob

	command -v python-latest > /dev/null || {
		echo 'python-latest not found in PATH'
		exit 1
	}

	declare PIPSI_HOME="${PIPSI_HOME?:PIPSI_HOME env var not set}"
	declare DOTFILES="${DOTFILES?:DOTFILES env var not set}"
	declare package

	case "$1" in
		install)
			shift
			command pipsi install --python "$(python-latest)" "$@"
			;;
		uninstall)
			command pipsi "$@"
			shift
			;;
		*)
			command pipsi "$@"
			return
			;;
	esac

	{
		echo '#'
		echo '# THIS IS A GENERATED FILE. DO NOT EDIT DIRECTLY.'
		echo '#'
		echo '- pipsi:'

		for package in "$PIPSI_HOME"/*; do
			echo "  - $(basename "$package")"
		done
	} > "$DOTFILES"/.lib/config/generated/packages.pipsi.yml
)
