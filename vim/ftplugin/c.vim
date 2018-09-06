setlocal softtabstop=0
setlocal noexpandtab

let b:ale_fixers = [
    \ 'uncrustify',
    \ ]

let b:ale_c_uncrustify_options = '-l C'
