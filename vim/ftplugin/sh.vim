let b:ale_fixers = [
    \ 'shfmt',
    \ ]

let b:ale_linters = [
    \ 'shellcheck',
    \ 'language_server',
    \ ]

let b:ale_sh_shfmt_options = '-i 4 -ci -bn'

let b:sh_fold_enabled = 1
