setlocal foldmethod=syntax

let b:ale_fixers = [
    \ 'prettier',
    \ 'tslint',
    \ ]

let b:ale_linters = [
    \ 'tslint',
    \ 'tsserver',
    \ ]

let b:ale_javascript_prettier_options = vimrc#MergeALEOptions('ale_javascript_prettier_options', [
    \ '--print-width=100',
    \ '--trailing-comma=all',
    \])

if expand('%:t:r') =~# '[-.]test$'
    UltiSnipsAddFiletypes javascript-jest
endif

