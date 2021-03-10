# shellcheck shell=bash
#
# Update the pacman mirrorlist using reflector and preset options.
#

command -v pacman > /dev/null || return
command -v reflector > /dev/null || return

pacman-update-mirrorlist() {
	sudo reflector \
		--verbose \
		--country 'United States' \
		--latest 15 \
		--protocol https \
		--sort rate \
		--save /etc/pacman.d/mirrorlist
}
