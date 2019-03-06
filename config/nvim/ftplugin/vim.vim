setlocal foldlevel=0
setlocal foldmethod=marker
setlocal foldtext=foldtext()

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal foldlevel< foldmethod< foldtext<'

let g:vimsyn_folding = 'af'

let b:ale_linters = [
    \ 'vint',
    \ ]
