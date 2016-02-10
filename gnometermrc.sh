#!/bin/bash

PROFILE_ID="$(dconf list /org/gnome/terminal/legacy/profiles:/)"
DCONF_PATH="/org/gnome/terminal/legacy/profiles:/${PROFILE_ID}"


dconf write ${DCONF_PATH}use-system-font			"false"
dconf write ${DCONF_PATH}cursor-shape     			"'block'"
dconf write ${DCONF_PATH}use-theme-colors 			"false"
dconf write ${DCONF_PATH}use-transparent-background 		"false"
dconf write ${DCONF_PATH}font 					"'Hack 15'"
dconf write ${DCONF_PATH}use-theme-transparency 		"true"
dconf write ${DCONF_PATH}bold-color-same-as-fg 			"true"
dconf write ${DCONF_PATH}audible-bell 				"false"
# NOTE: The palate is colored starting with top-left and proceeding rightward
# 	ending at the bottom right

# Theme: Material (www.terminal.sexy)
dconf write ${DCONF_PATH}foreground-color "'#eceff1'"
dconf write ${DCONF_PATH}background-color "'#263238'"
dconf write ${DCONF_PATH}palette \
"
['#263238', '#ff9800', '#8bc34a', '#ffc107', '#03a9f4', '#e91e63', '#009688', '#cfd8dc', '#37474f', '#ffa74d', '#9ccc65', '#ffa000', '#81d4fa', '#ad1457', '#26a69a', '#eceff1']
"
