# shellcheck shell=bash disable=SC1090
# Redirect all stdout to /dev/null
{
	# source completion loader or exit if not available
	if ! command -v __load_completion; then
		while true; do
			for f in /usr/{local/,}share/bash-completion/bash_completion; do
				if [ -f "$f" ]; then
					. "$f"
					break 2
				fi
			done
			return
		done
	fi

	# Add completion aliases where needed
	command -v docker \
		&& __load_completion docker \
		&& command -v _docker \
		&& complete -F _docker d

	command -v docker-compose \
		&& __load_completion docker-compose \
		&& command -v _docker_compose \
		&& complete -F _docker_compose dc

	command -v docker-machine \
		&& __load_completion docker-machine \
		&& command -v _docker_machine \
		&& complete -F _docker_machine dm

	command -v git \
		&& __load_completion git \
		&& command -v __git_complete \
		&& command -v __git_main \
		&& __git_complete g __git_main

	command -v hub \
		&& __load_completion hub \
		&& command -v _git \
		&& complete -o bashdefault -o default -o nospace -F _git g

	command -v task \
		&& __load_completion task \
		&& command -v _task \
		&& complete -o nospace -F _task t

	command -v terraform \
		&& complete -C "$(command -v terraform)" terraform

	command -v yarn \
		&& __load_completion yarn \
		&& command -v _yarn \
		&& complete -F _yarn y

} > /dev/null
