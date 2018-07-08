# shellcheck shell=bash
# Stub out "hub" when its commands conflict with better "git-extras" commands
hub-stub-conflicting-commands() {
    case "$1" in
        alias | fork | pr)
            command git "$@"
            ;;
        browse)
            # Fix for random error that always shows up but doesn't actually matter
            command hub "$@" 2>/dev/null
            ;;
        *)
            command hub "$@"
            ;;
    esac
}
