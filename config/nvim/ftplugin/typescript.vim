" Sort imports by path
command! -buffer -range -nargs=0 SortImports <line1>,<line2>sort r /from ['"]\zs[^'"]\+/

" Transforms a selected range of JSDoc into TSDoc
command! -range TSDocify <line1>,<line2>call vimrc#ftplugin#typescript#tsdocify()

let b:ale_fixers = [
    \ 'prettier',
    \ 'tslint',
    \ 'eslint',
    \ ]

let b:ale_linters = [
    \ 'tsserver',
    \ 'eslint',
    \ 'tslint',
    \ ]

let b:ale_quick_fixer = 'prettier'

let b:ale_javascript_prettier_options = vimrc#merge_ale_options('ale_javascript_prettier_options', [
    \ '--print-width=100',
    \ '--trailing-comma=all',
    \])

if expand('%:t:r') =~# '[-.]test$'
    UltiSnipsAddFiletypes jest.typescript
endif

