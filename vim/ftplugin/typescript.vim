let b:ale_fixers = [
    \ 'prettier',
    \ 'tslint',
    \ ]

let b:ale_linters = [
    \ 'tslint',
    \ 'tsserver',
    \ ]

nnoremap <buffer> <silent> K :ALEHover<CR>
nnoremap <buffer> <silent> gd :ALEGoToDefinition<CR>
nnoremap <buffer> <silent> gr :ALEFindReferences<CR>

