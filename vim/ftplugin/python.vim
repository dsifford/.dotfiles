setlocal keywordprg=:ALEHover

let b:ale_fixers = [
    \ 'black',
    \ 'isort',
    \ ]

" FIXME: pyre is on the fritz
let b:ale_linters = [
    \ 'pylint',
    \ 'pyls',
    \ ]

let b:ale_python_isort_options = '--multi-line=3 --trailing-comma --force-grid-wrap=0 --combine-as --line-width=88'
