if expand('%:t') ==# 'PULLREQ_EDITMSG'
    setlocal wrap

    let b:undo_ftplugin = vimrc#undo_ftplugin(
        \ 'setlocal wrap<',
        \)
endif
