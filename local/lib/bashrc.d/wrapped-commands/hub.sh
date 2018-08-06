# shellcheck shell=bash
#
# Stub out "hub" when its commands conflict with better "git-extras" commands
#

if command -v hub > /dev/null; then

    hub() {
        case "$1" in
            alias)
                command git "$@"
                ;;
            *)
                command hub "$@"
                ;;
        esac
    }

fi
