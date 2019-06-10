setlocal foldmethod=syntax

" Sort imports by path
command! -buffer -range -nargs=0 SortImports '<,'>sort r /from ['"]\zs[^'"]\+/

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

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'setlocal foldmethod<',
    \ 'unlet b:ale_fixers b:ale_linters b:ale_javascript_prettier_options',
    \ 'delcommand SortImports'
    \)

if expand('%:t:r') =~# '[-.]test$'
    UltiSnipsAddFiletypes jest.typescript
endif

