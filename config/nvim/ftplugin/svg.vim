let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:ale_javascript_prettier_options = vimrc#mergeALEOptions('ale_javascript_prettier_options', [
    \ '--parser=html',
    \])
