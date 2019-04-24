setlocal foldmethod=syntax

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal foldmethod<'

let b:ale_fixers = [
    \ 'prettier',
    \ 'tslint',
    \ ]

let b:ale_linters = [
    \ 'tsserver',
    \ ]

let b:ale_javascript_prettier_options = vimrc#merge_ale_options('ale_javascript_prettier_options', [
    \ '--print-width=100',
    \ '--trailing-comma=all',
    \])

if expand('%:t:r') =~# '[-.]test$'
    UltiSnipsAddFiletypes javascript-jest
endif

