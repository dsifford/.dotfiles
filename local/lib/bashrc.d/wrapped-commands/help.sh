# shellcheck shell=bash
# Always pipe the output of `help` to $PAGER
help() {
	command help -m "$@" | "$PAGER"
}

