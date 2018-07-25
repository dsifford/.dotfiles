# shellcheck shell=bash
#
# Wrap pipsi so that the install subcommand always installs to the latest
# version of python available in the PATH
#

if command -v pipsi > /dev/null; then

    pipsi() {
        case "$1" in
            install)
                shift
                command pipsi install --python "$(python-latest)" "$@"
                ;;
            *)
                command pipsi "$@"
                ;;
        esac
    }

fi
