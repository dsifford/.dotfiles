setlocal foldmethod=syntax
setlocal omnifunc=

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal foldmethod< omnifunc<'

let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:ale_linters = [
    \ 'tsserver',
    \ ]

let g:javascript_plugin_jsdoc = 1

if expand('%:t:r') =~# '[-.]test$'
    UltiSnipsAddFiletypes javascript-jest
endif