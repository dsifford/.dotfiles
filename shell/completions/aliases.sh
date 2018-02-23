#!/usr/bin/env bash

complete -F _docker d
complete -F _docker_compose dc
complete -F _docker_machine dm
__git_complete g __git_main
complete -o nospace -F _task t
complete -F _yarn y
