setlocal foldlevel=0
setlocal foldmethod=marker
setlocal foldtext=foldtext()

let g:vimsyn_folding = 'af'

let b:ale_linters = [
    \ 'vint',
    \ ]

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'setlocal foldlevel< foldmethod< foldtext<',
    \ 'unlet b:ale_linters'
    \)
