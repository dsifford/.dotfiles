let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:ale_javascript_prettier_options = vimrc#merge_ale_options('ale_javascript_prettier_options', [
    \ '--parser=html',
    \])
