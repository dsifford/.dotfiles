# shellcheck shell=bash
#
# Attempts to pull the latest update of all images, specified by the exiting tag
# of the image on the system.
#
# When finished, all dangling images are removed (if not a dependency of a child image)
#

if command -v docker > /dev/null && command -v parallel > /dev/null; then

	docker-update-images() {
		docker images --format '{{.Repository}}:{{.Tag}}' --filter dangling=false \
			| parallel 'docker pull {}'

		# shellcheck disable=2046
		docker rmi $(docker images --filter dangling=true -q) 2> /dev/null
	}

fi
