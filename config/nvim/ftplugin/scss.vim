setlocal foldmarker={,}
setlocal foldmethod=marker
setlocal foldnestmax=3

let b:ale_fixers = [
    \ 'prettier',
    \ 'stylelint',
    \ ]

let b:ale_linters = [
    \ 'stylelint',
    \ ]

let b:undo_ftplugin=vimrc#undo_ftplugin(
    \ 'setlocal foldmarker< foldmethod< foldnestmax<',
    \ 'unlet b:ale_fixers b:ale_linters'
    \)
