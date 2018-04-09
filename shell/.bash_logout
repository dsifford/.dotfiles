# shellcheck shell=bash
#
# ~/.bash_logout
#

# $XDG_CACHE_HOME -> files not accessed for >90 days
find "${XDG_CACHE_HOME:-$HOME/.cache}" -type f -atime +90 -delete

# $XDG_CACHE_HOME -> empty directories
find "${XDG_CACHE_HOME:-$HOME/.cache}" -type d -empty -delete

# Clear out history files from session
__misc_history_files=(
    ~/.bash_history
    ~/.python_history
)
for __file in "${__misc_history_files[@]}"; do
    rm -f "$__file"
done
unset __file __misc_history_files

