setlocal commentstring=//\ %s

let g:php_folding   = 2 " Fold classes and functions
let g:php_baselib   = 1 " Highlight baselib functions

let g:PHP_outdentphpescape = 0                    " Indent escape tags at level surrounding
let g:PHP_IndentFunctionCallParameters = 1        " Indent function call parameters
let g:PHP_IndentFunctionDeclarationParameters = 1 " Indent function declaration parameters

let b:ale_fixers = [
  \ 'phpcbf',
  \ ]

let b:ale_linters = [
  \ 'phpcs',
  \ 'php',
  \ ]

let b:undo_ftplugin = vimrc#undo_ftplugin(
  \ 'setlocal commentstring<',
  \ 'unlet b:ale_fixers b:ale_linters'
  \)
