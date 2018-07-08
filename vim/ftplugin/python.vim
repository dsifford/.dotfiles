let b:ale_fixers = [
    \ 'black',
    \ 'isort',
    \ ]

let b:ale_linters = [
    \ 'pyre',
    \ 'pylint',
    \ ]

let b:ale_python_isort_options = '--multi-line=3 --trailing-comma --force-grid-wrap=0 --combine-as --line-width=88'
