setlocal commentstring=//\ %s
setlocal foldmethod=syntax

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal commentstring< foldmethod<'

let b:ale_fixers = [
    \ 'phpcbf',
    \ ]

let b:ale_linters = [
    \ 'phpcs',
    \ 'php',
    \ ]

let g:php_folding   = 2 " Fold classes and functions
let g:php_baselib   = 1 " Highlight baselib functions
