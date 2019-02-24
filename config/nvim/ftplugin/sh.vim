let b:ale_fixers = [
    \ 'shfmt',
    \ ]
let b:ale_linters = [
    \ 'shellcheck',
    \ ]

let g:sh_fold_enabled = 1

" Necessary to delay calling and setting of this until after Editorconfig runs
call timer_start(200, { timer ->
    \   execute('let b:ale_sh_shfmt_options = "-i ' . (&expandtab == 1 ? '4' : '0') . ' -ci -bn -sr"')
    \ })
