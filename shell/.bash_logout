# shellcheck shell=bash
#
# ~/.bash_logout
#

# Clear out history files from session
for __file in ~/.bash_history ~/.python_history; do
    rm -f "$__file"
done
