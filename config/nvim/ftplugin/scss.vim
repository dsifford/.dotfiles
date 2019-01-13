setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal foldnestmax=3

let b:ale_fixers = [
    \ 'prettier',
    \ 'stylelint',
    \ ]

let b:ale_linters = [
    \ 'stylelint',
    \ ]
