let g:vim_markdown_auto_insert_bullets     = 0 " Don't insert list items automatically
let g:vim_markdown_emphasis_multiline      = 0 " Restrict italics to single line only
let g:vim_markdown_folding_style_pythonic  = 1 " Fold at header line rather than line below
let g:vim_markdown_frontmatter             = 1 " Enable frontmatter yaml highlighting
let g:vim_markdown_new_list_item_indent    = 0 " Don't indent automatically
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_fenced_languages = [
    \ 'ts=typescript',
    \ 'yml=yaml'
    \ ]

let b:ale_fixers = [
    \ 'prettier',
    \ ]

" Fixes the issue where prettier adds unnecessary spacing after bullets with tab width > 2
let b:ale_javascript_prettier_options = vimrc#merge_ale_options('ale_javascript_prettier_options', [
    \ '--tab-width=2',
    \])

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'unlet b:ale_fixers b:ale_javascript_prettier_options'
    \)
