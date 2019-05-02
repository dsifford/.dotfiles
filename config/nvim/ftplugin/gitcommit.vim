if expand('%:t') ==# 'PULLREQ_EDITMSG'
    setlocal formatoptions-=t " Don't add line breaks to wrapped lines
    setlocal wrap

    let b:undo_ftplugin=vimrc#undo_ftplugin(
        \ 'setlocal formatoptions< wrap<',
        \)
endif
