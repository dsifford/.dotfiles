# shellcheck shell=bash
#
# Attempts to pull the latest update of all images, specified by the exiting tag
# of the image on the system.
#
# When finished, all dangling images are removed (if not a dependency of a child image)
#

command -v docker > /dev/null || return

docker-update-images() {
	docker images --format '{{.Repository}}:{{.Tag}}' --filter dangling=false \
		| xargs -n 1 -P 0 docker pull \
		| sed -n '/^Status.*/p'

	# Delete old dangling images
	docker images --filter dangling=true -q \
		| xargs --no-run-if-empty docker rmi \
		| sed -n '/^Deleted.*/!p'
}
