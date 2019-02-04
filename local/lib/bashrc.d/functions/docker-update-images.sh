# shellcheck shell=bash
#
# Attempts to pull the latest update of all images, specified by the exiting tag
# of the image on the system.
#
# When finished, all dangling images are removed (if not a dependency of a child image)
#

command -v docker > /dev/null || return

docker-update-images() {
	declare -a to_delete

	docker images --format '{{.Repository}}:{{.Tag}}' --filter dangling=false \
		| xargs -n 1 -P 0 docker pull

	mapfile -t to_delete < <(docker images --filter dangling=true -q)

	docker rmi "${to_delete[@]}" 2> /dev/null
}
