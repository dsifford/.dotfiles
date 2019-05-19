setlocal iskeyword+=-
setlocal iskeyword+=.

" Open github page of plugin name under cursor.
nnoremap <buffer> K <Cmd>
    \ if executable('xdg-open')                                                                                 \|
    \   silent exec '! xdg-open https://' . matchstr(g:plugs[expand('<cword>')]['uri'], 'github.com.*\ze\.git') \|
    \ elseif executable('open')                                                                                 \|
    \   silent exec '! open https://' . matchstr(g:plugs[expand('<cword>')]['uri'], 'github.com.*\ze\.git')     \|
    \ endif<CR>

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'setlocal iskeyword<',
    \ 'nmapclear <buffer>',
    \)
