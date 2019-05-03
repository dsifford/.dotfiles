if w:quickfix_title ==# 'Man TOC'
    nnoremap <buffer> <silent> <Enter> :exec 'll' . line('.') <Bar> :lcl<CR>
    nnoremap <buffer> <silent> q :wq<CR>
endif

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'nmapclear <buffer>',
    \)
