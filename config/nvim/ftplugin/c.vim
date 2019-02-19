setlocal noexpandtab
setlocal softtabstop=0

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal expandtab< softtabstop<'

let b:ale_fixers = [
    \ 'uncrustify',
    \ ]

let b:ale_c_uncrustify_options = '-l C'
