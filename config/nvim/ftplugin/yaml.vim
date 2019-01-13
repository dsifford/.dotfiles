let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:ale_javascript_prettier_options = vimrc#MergeALEOptions('ale_javascript_prettier_options', [
    \ '--tab-width=2',
    \])
