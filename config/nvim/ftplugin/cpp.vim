setlocal noexpandtab
setlocal softtabstop=0

let b:ale_fixers = [
    \ 'uncrustify',
    \ ]

let b:ale_c_uncrustify_options = '-l CPP'

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'unlet b:ale_c_uncrustify_options'
    \)
