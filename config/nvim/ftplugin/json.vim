setlocal foldmethod=syntax

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal foldmethod<'

let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:ale_javascript_prettier_options = vimrc#merge_ale_options('ale_javascript_prettier_options', [
    \ '--parser=json-stringify',
    \])

let b:undo_ftplugin=vimrc#undo_ftplugin(
    \ 'setlocal foldmethod<',
    \ 'unlet b:ale_fixers b:ale_javascript_prettier_options'
    \)
