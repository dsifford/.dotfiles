if w:quickfix_title ==# 'Man TOC'
    " Go to item from table of contents with <Enter>
    nnoremap <buffer> <silent> <Enter> :exec 'll' . line('.') <Bar> :lcl<CR>
    nnoremap <buffer> <silent> q :wq<CR>
endif

nnoremap <buffer> <silent> dd <Cmd>call vimrc#lists#delete_item_at_cursor()<CR>

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'nmapclear <buffer>',
    \)
