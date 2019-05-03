let b:ale_fixers = [
    \ 'terraform',
    \ ]

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'unlet b:ale_fixers'
    \)
