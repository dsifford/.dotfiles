setlocal foldmethod=syntax
setlocal omnifunc=

let g:javascript_plugin_jsdoc = 1

let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:ale_linters = [
    \ 'tsserver',
    \ ]

let b:undo_ftplugin=vimrc#undo_ftplugin(
    \ 'setlocal foldmethod< omnifunc<',
    \ 'unlet b:ale_fixers b:ale_linters'
    \)

if expand('%:t:r') =~# '[-.]test$'
    UltiSnipsAddFiletypes javascript-jest
endif
