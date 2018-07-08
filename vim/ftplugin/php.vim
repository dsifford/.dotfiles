setlocal commentstring=//\ %s
setlocal nofoldenable
setlocal foldmethod=syntax

let b:ale_fixers = [
    \ 'phpcbf',
    \ ]

let b:ale_linters = [
    \ 'phpcs',
    \ 'php',
    \ 'langserver',
    \ ]

let b:php_folding   = 1 " Fold classes and functions
let b:php_baselib   = 1 " Highlight baselib functions
