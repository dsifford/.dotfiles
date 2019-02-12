# shellcheck shell=bash
#
# List all tags of a given remote docker image.
#

docker-list-tags() {
	declare endpoint="https://registry.hub.docker.com/v1/repositories/$1/tags"
	declare -i code
	code=$(curl -s -w '%{http_code}' -o /dev/null "$endpoint")
	if ((code == 200)); then
		curl -s "$endpoint" | jq --raw-output '.[].name'
	else
		>&2 echo "Image $1 does not exist"
		exit 1
	fi
}
