func! s:foldtext()
    let line = getline(v:foldstart)
    return '+' . v:folddashes . ' ' . line
endfunc
let b:foldtext = function('s:foldtext')

func! s:set_opts(tid)
    let b:ale_sh_shfmt_options = '-i ' . (&expandtab == 1 ? '4' : '0') . ' -ci -bn -sr'
endfunc

let g:sh_fold_enabled = 1
let b:ale_fixers = [
    \ 'shfmt',
    \ ]
let b:ale_linters = [
    \ 'shellcheck',
    \ ]

setlocal foldtext=b:foldtext()
setlocal nofoldenable

nnoremap <silent> <buffer> <LocalLeader><CR> :setlocal foldenable!<CR>

" Necessary to delay calling and setting of this until after Editorconfig runs
call timer_start(200, function('s:set_opts'))
