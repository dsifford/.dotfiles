setlocal noexpandtab
setlocal softtabstop=0

let b:ale_fixers = [
    \ 'uncrustify',
    \ ]

let b:ale_c_uncrustify_options = '-l C'

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'setlocal expandtab< softtabstop<',
    \ 'unlet b:ale_fixers'
    \)
