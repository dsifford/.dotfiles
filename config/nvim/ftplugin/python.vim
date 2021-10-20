let g:python_highlight_all = 1

let b:ale_fixers = [
    \ 'black',
    \ 'isort',
    \ ]

let b:ale_linters = [
    \ 'bandit',
    \ 'mypy',
    \ 'pylint',
    \ 'pyls',
    \ ]

let b:ale_python_isort_options = '--multi-line=3 --trailing-comma --force-grid-wrap=0 --combine-as --line-width=88'
let b:ale_python_bandit_options = '--ini $XDG_CONFIG_HOME/bandit/bandit.ini'

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'unlet b:ale_fixers b:ale_linters b:ale_python_isort_options b:ale_python_bandit_options'
    \)
