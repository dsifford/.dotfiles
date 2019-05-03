let b:ale_linters = [
    \ 'hadolint',
    \ ]

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'unlet b:ale_linters'
    \)

" vim: set ft=vim:
