setlocal commentstring=//\ %s
setlocal foldmethod=syntax

let b:ale_fixers = [
    \ 'phpcbf',
    \ ]

let b:ale_linters = [
    \ 'phpcs',
    \ 'php',
    \ ]

let g:php_folding   = 1 " Fold classes and functions
let g:php_baselib   = 1 " Highlight baselib functions
let g:php_sql_query = 1 " Highlight SQL in strings

hi! link Delimiter DraculaPink
augroup dsifford_php
    autocmd! BufLeave <buffer> hi! link Delimiter DraculaFg
augroup END
