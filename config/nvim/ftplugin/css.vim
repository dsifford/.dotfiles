setlocal foldmarker={,}
setlocal foldmethod=marker
setlocal foldnestmax=3

let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'setlocal foldmarker< foldmethod< foldnestmax<',
    \ 'unlet b:ale_fixers'
    \)
