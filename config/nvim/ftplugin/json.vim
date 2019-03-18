setlocal foldmethod=syntax

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal foldmethod<'

let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:ale_javascript_prettier_options = vimrc#mergeALEOptions('ale_javascript_prettier_options', [
    \ '--parser=json-stringify',
    \])
