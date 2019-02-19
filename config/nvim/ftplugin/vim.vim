setlocal foldlevel=0
setlocal foldtext=foldtext()

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal foldlevel< foldtext<'

let g:vimsyn_folding = 'af'

let b:ale_linters = [
    \ 'vint',
    \ ]
