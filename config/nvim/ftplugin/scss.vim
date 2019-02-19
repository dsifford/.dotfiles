setlocal foldmarker={,}
setlocal foldmethod=marker
setlocal foldnestmax=3

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal foldmarker< foldmethod< foldnestmax<'

let b:ale_fixers = [
    \ 'prettier',
    \ 'stylelint',
    \ ]

let b:ale_linters = [
    \ 'stylelint',
    \ ]
