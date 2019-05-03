setlocal commentstring=//\ %s
setlocal foldmethod=syntax

let g:php_folding   = 2 " Fold classes and functions
let g:php_baselib   = 1 " Highlight baselib functions

let b:ale_fixers = [
    \ 'phpcbf',
    \ ]

let b:ale_linters = [
    \ 'phpcs',
    \ 'php',
    \ ]

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'setlocal commentstring< foldmethod<',
    \ 'unlet b:ale_fixers b:ale_linters'
    \)
