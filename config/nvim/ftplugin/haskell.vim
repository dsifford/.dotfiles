let b:ale_fixers = [
    \ 'brittany',
    \ ]

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'unlet b:ale_fixers'
    \)
