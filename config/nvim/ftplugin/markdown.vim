let b:ale_fixers = [
    \ 'prettier',
    \ ]


let g:vim_markdown_emphasis_multiline      = 0 " Restrict italics to single line only
let g:vim_markdown_folding_style_pythonic  = 1 " Fold at header line rather than line below
let g:vim_markdown_frontmatter             = 1 " Enable frontmatter yaml highlighting
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_fenced_languages = [
    \ 'ts=typescript',
    \ 'yml=yaml'
    \ ]
