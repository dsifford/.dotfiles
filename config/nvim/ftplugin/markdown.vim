let b:ale_fixers = [
    \ 'prettier',
    \ ]


let g:vim_markdown_emphasis_multiline = 0 " Restrict italics to single line only
let g:markdown_folding = 1                " Enable folding of headers
let g:vim_markdown_frontmatter = 1        " Enable frontmatter yaml highlighting
let g:markdown_fenced_languages = [
    \ 'html',
    \ 'python',
    \ 'ts=typescript',
    \ 'yml=yaml'
    \ ]

augroup dsifford
    " Removes indent highlighting of code blocks due to issue with indented lists.
    autocmd Syntax markdown syntax clear markdownCodeBlock
augroup END

