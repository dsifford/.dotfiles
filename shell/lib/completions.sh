#!/bin/bash

# Source all generated completions
# shellcheck disable=SC1090
{
	command -v rustup >/dev/null &&
		source <(rustup completions bash)
	command -v npm >/dev/null &&
		source <(npm completion)
	command -v doctl >/dev/null &&
		source <(doctl completion bash)
	command -v pandoc >/dev/null &&
		source <(pandoc --bash-completion)
}

# Add completion aliases where needed
command -v _docker >/dev/null &&
	complete -F _docker d
command -v _docker_compose >/dev/null &&
	complete -F _docker_compose dc
command -v _docker_machine >/dev/null &&
	complete -F _docker_machine dm
command -v __git_complete >/dev/null &&
	__git_complete g __git_main
command -v _task >/dev/null &&
	complete -o nospace -F _task t
command -v _yarn >/dev/null &&
	complete -F _yarn y
