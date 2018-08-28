let b:ale_fixers = [
    \ 'shfmt',
    \ ]

let b:ale_linters = [
    \ 'shellcheck',
    \ ]

function! s:set_opts(tid)
    let b:ale_sh_shfmt_options = '-i ' . (&expandtab == 1 ? '4' : '0') . ' -ci -bn -sr'
endfunction

" Necessary to delay calling and setting of this until after Editorconfig runs
call timer_start(200, function('s:set_opts'))

let b:sh_fold_enabled = 1
