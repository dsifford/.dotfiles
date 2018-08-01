let b:ale_fixers = [
    \ 'prettier',
    \ 'tslint',
    \ ]

let b:ale_linters = [
    \ 'tslint',
    \ 'tsserver',
    \ ]

if expand('%:t:r') =~# '[-.]test$'
    UltiSnipsAddFiletypes javascript-jest
endif
