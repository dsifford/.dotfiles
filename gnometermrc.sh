#!/bin/bash

PROFILE_ID="$(dconf list /org/gnome/terminal/legacy/profiles:/)"
DCONF_PATH="/org/gnome/terminal/legacy/profiles:/${PROFILE_ID}"


dconf write ${DCONF_PATH}foreground-color			"'rgb(211,215,207)'"
dconf write ${DCONF_PATH}background-color 			"'rgb(0,48,81)'"
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
dconf write ${DCONF_PATH}palette \
	"[
		'rgb(78,78,78)',
		'rgb(255,107,96)',
		'rgb(250,176,54)',
		'rgb(255,255,182)',
		'rgb(86,150,237)',
		'rgb(255,115,253)',
		'rgb(142,228,120)',
		'rgb(238,238,238)',
		'rgb(79,79,79)',
		'rgb(249,104,96)',
		'rgb(250,176,54)',
		'rgb(253,255,184)',
		'rgb(107,159,237)',
		'rgb(252,110,249)',
		'rgb(142,228,120)',
		'rgb(255,255,255)'
	]"
