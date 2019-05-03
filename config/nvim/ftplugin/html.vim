if &filetype !=# 'html'
    finish
endif

let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'unlet b:ale_fixers'
    \)
