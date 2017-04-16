# shellcheck shell=bash
#
# Version: 0.1.1
#
# bash completion for Yarn (https://github.com/yarnpkg/yarn)
#
# To enable the completions either:
#  - place this file in /etc/bash_completion.d
#  or
#  - copy this file to e.g. ~/.yarn-completion.sh and add the line
#    below to your .bashrc after bash completion features are loaded
#    . ~/.yarn-completion.sh
#

# Returns the object keys for a given first-level property
# in a package.json file located in the current directory if it exists.
#
# @param $1 parentField  The first-level property of interest.
#
__yarn_get_package_fields() {
    local parentField="$1"
    local package
    local fields
    
    package="$(pwd)/package.json"
    
    [ ! -e "$package" ] && return

    fields=$(
        sed -n "/\"$parentField\": {/,/\}/p" < "$package" |
        head -n -1 |
        tail -n +2 |
        sed -e 's/^[ \t]*//gm' |
        grep -Po '"\K[^"]*(?=":)'
    )
    fields=( $fields )

    echo "${fields[*]}"
}

# Returns the names of the globally installed packages.
__yarn_get_globals() {
    local packages
    local bin_path
    bin_path="$(yarn global bin)"
    packages=$(
        find "$bin_path" -type l |
        grep -Po "$bin_path/\K.+" |
        sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ /g'
    )
    echo "$packages"
}

_yarn_add() {
    local flags=(
        --dev
        --exact
        --optional
        --peer
        --tilde
    )
    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${flags[*]}" -- "$cur" ) )
            ;;
    esac
}

_yarn_cache() {
    [[ "$prev" != cache ]] && return
    local subcommands=(
        clean
        dir
        ls
    )
    COMPREPLY=( $( compgen -W "${subcommands[*]}" -- "$cur" ) )
}

_yarn_check() {
    local flags=(
        --integrity
    )
    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${flags[*]}" -- "$cur" ) )
            ;;
    esac
}

_yarn_config() {
    local subcommands=(
        delete
        get
        list
        set
    )
    local known_keys=(
        ignore-optional
        ignore-platform
        ignore-scripts
        init-author-email
        init-author-name
        init-author-url
        init-license
        init-version
        no-progress
        prefix
        registry
        save-prefix
        user-agent
        version-git-message
        version-git-sign
        version-git-tag
        version-tag-prefix
    )
    
    case "$prev" in
        get|delete)
            COMPREPLY=( $( compgen -W "${known_keys[*]}" -- "$cur" ) )
            ;;
        set)
            if [[ "$cur" == -* ]]; then
                COMPREPLY=( $( compgen -W "--global" -- "$cur" ) )
            else
                COMPREPLY=( $( compgen -W "${known_keys[*]}" -- "$cur" ) )
            fi
            ;;
        config)
            COMPREPLY=( $( compgen -W "${subcommands[*]}" -- "$cur" ) )
            ;;
    esac
}

_yarn_global() {
    local subcommands=(
        add
        bin
        ls
        remove
        upgrade
        upgrade-interactive
    )

    case "$prev" in
        add|bin|remove|upgrade|upgrade_interactive)
            local global_completions_func=_yarn_${prev}
            declare -F "$global_completions_func" >/dev/null && $global_completions_func global
            ;;
        ls|--depth)
            _yarn_list
            ;;
        global)
            COMPREPLY=( $( compgen -W "${subcommands[*]}" -- "$cur" ) )
            ;;
    esac
}

_yarn_info() {
    local flags=(
        --json
    )
    local standard_fields=(
        author
        bin
        bugs
        contributors
        dependencies
        description
        devDependencies
        dist-tags
        engines
        files
        homepage
        keywords
        license
        main
        maintainers
        name
        optionalDependencies
        peerDependencies
        repository
        version
    )

    [[ "$prev" == info ]] && return

    local args
    _count_args :

    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${flags[*]}" -- "$cur" ) )
            ;;
        *)
            if [[ $args -eq 3 ]]; then
                COMPREPLY=( $( compgen -W "${standard_fields[*]}" -- "$cur" ) )
            fi
            ;;
    esac
}

_yarn_init() {
    local flags=(
        --yes
    )
    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${flags[*]}" -- "$cur" ) )
            ;;
    esac
}

_yarn_install() {
    local flags=(
        --flat
        --force
        --har
        --modules-folder
        --no-lockfile
        --production
        --pure-lockfile
    )

    case "$prev" in
        --modules-folder)
            _filedir
            return
            ;;
    esac

    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${flags[*]}" -- "$cur" ) )
            ;;
    esac
}

_yarn_licenses() {
    [[ "$prev" != licenses ]] && return
    local subcommands=(
        ls
        generate-disclaimer
    )
    COMPREPLY=( $( compgen -W "${subcommands[*]}" -- "$cur" ) )
}

_yarn_list() {
    local flags=(
        --depth
    )

    case "$prev" in
        --depth)
            COMPREPLY=( $( compgen -W '{0..9}' -- "$cur" ) )
            return
            ;;
    esac

    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${flags[*]}" -- "$cur" ) )
            ;;
    esac
}

_yarn_outdated() {
    [[ "$prev" != outdated ]] && return
    local dependencies
    local devDependencies
    dependencies=$(__yarn_get_package_fields dependencies)
    devDependencies=$(__yarn_get_package_fields devDependencies)
    COMPREPLY=( $( compgen -W "$dependencies $devDependencies" -- "$cur" ) )
}

_yarn_owner() {
    [[ "$prev" != owner ]] && return
    local subcommands=(
        add
        ls
        rm
    )
    COMPREPLY=( $( compgen -W "${subcommands[*]}" -- "$cur" ) )
}

_yarn_pack() {
    local flags=(
        --filename
    )
    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${flags[*]}" -- "$cur" ) )
            return
            ;;
    esac
    [[ "$prev" == --filename ]] && _filedir
}

_yarn_publish() {
    local flags=(
        --access
        --tag
    )
    case "$prev" in
        --access)
            COMPREPLY=( $( compgen -W "public restricted" -- "$cur" ) )
            return
            ;;
        --tag)
            return
            ;;
    esac
    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${flags[*]}" -- "$cur" ) )
            return
            ;;
    esac

    _filedir
}

_yarn_remove() {
    local location="$1"
    local dependencies
    local devDependencies
    if [[ "$location" == 'global' ]]; then
        dependencies=$(__yarn_get_globals)
        devDependencies=''
    else
        dependencies=$(__yarn_get_package_fields dependencies)
        devDependencies=$(__yarn_get_package_fields devDependencies)
    fi
    COMPREPLY=( $( compgen -W "$dependencies $devDependencies" -- "$cur" ) )
}

_yarn_run() {
    [[ "$prev" != run ]] && return
    COMPREPLY=( $( compgen -W "$(__yarn_get_package_fields scripts)" -- "$cur" ) )
}

_yarn_tag() {
    [[ "$prev" != tag ]] && return
    local subcommands=(
        add
        ls
        rm
    )
    COMPREPLY=( $( compgen -W "${subcommands[*]}" -- "$cur" ) )
}

_yarn_team() {
    [[ "$prev" != team ]] && return
    local subcommands=(
        add
        create
        destroy
        ls
        rm
    )
    COMPREPLY=( $( compgen -W "${subcommands[*]}" -- "$cur" ) )
}

_yarn_upgrade() {
    local location="$1"
    local dependencies
    local devDependencies
    local flags=(
        --ignore-engines
    )
    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${flags[*]}" -- "$cur" ) )
            return
            ;;
    esac
    if [[ "$location" == global ]]; then
        dependencies=$(__yarn_get_globals)
        devDependencies=''
    else
        dependencies=$(__yarn_get_package_fields dependencies)
        devDependencies=$(__yarn_get_package_fields devDependencies)
    fi
    COMPREPLY=( $( compgen -W "$dependencies $devDependencies" -- "$cur" ) )
}

_yarn_version() {
    local flags=(
        --new-version
        --no-git-tag-version
    )
    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${flags[*]}" -- "$cur" ) )
            ;;
    esac
}

_yarn_why() {
    local modules_folder
    local modules

    modules_folder="$(pwd)/node_modules"
    [ ! -d "$modules_folder" ] || [[ "$prev" != why ]] && return

    if [[ "$cur" == */ ]]; then
        _filedir
    else
        modules=$(
            find node_modules/ -maxdepth 1 -type d | grep -Po 'node_modules/\K.+'
        )
        COMPREPLY=( $( compgen -W "$modules" -- "$cur" ) )
    fi
}

_yarn_yarn() {
    local args
    _count_args :
    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "${global_flags[*]}" -- "$cur" ) )
            ;;
        *)
            if [[ $args -eq 1 ]]; then
                COMPREPLY=( $( compgen -W "${commands[*]}" -- "$cur" ) )
            fi
            ;;
    esac
}

_yarn() {
    local cur prev words cword

    local commands=(
        access
        add
        bin
        cache
        check
        clean
        config
        generate-lock-entry
        global
        help
        import
        info
        init
        install
        licenses
        link
        list
        login
        logout
        outdated
        owner
        pack
        publish
        remove
        run
        tag
        team
        unlink
        upgrade
        upgrade-interactive
        version
        why
    )

    local global_flags=(
        --cache-folder
        --check-files
        --flat
        --force
        --frozen-lockfile
        --global-folder
        --har
        --help
        --https-proxy
        --ignore-engines
        --ignore-optional
        --ignore-platform
        --ignore-scripts
        --json
        --link-duplicates
        --modules-folder
        --mutex
        --network-concurrency
        --network-timeout
        --no-bin-links
        --no-emoji
        --no-lockfile
        --no-progress
        --non-interactive
        --offline
        --prefer-offline
        --prod
        --production
        --proxy
        --pure-lockfile
        --silent
        --skip-integrity-check
        --strict-semver
        --verbose
        --version
    )

    COMPREPLY=()
    if declare -F _init_completions >/dev/null 2>&1; then
        _init_completion
    fi
    _get_comp_words_by_ref cur prev words cword

    local command=yarn
    local counter=1
    while [ $counter -lt "$cword" ]; do
        case "${words[$counter]}" in
            -*)
                ;;
            =)
                (( counter++ ))
                ;;
            *)
                command="${words[$counter]}"
                break
                ;;
        esac
        (( counter++ ))
    done

    local completions_func=_yarn_${command}
    declare -F "$completions_func" >/dev/null && $completions_func

    return 0
}

complete -F _yarn yarn