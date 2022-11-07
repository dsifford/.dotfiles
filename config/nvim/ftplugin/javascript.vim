setlocal omnifunc=

let g:javascript_plugin_jsdoc = 1

let b:ale_fixers = [
    \ 'prettier',
    \ 'eslint',
    \ ]

let b:ale_linters = [
    \ 'tsserver',
    \ 'eslint',
    \ ]

let b:ale_quick_fixer = 'prettier'

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'setlocal omnifunc<',
    \ 'unlet b:ale_fixers b:ale_linters'
    \)

if expand('%:t:r') =~# '[-.]test$'
    UltiSnipsAddFiletypes jest.javascript
endif
