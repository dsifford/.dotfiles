if expand('%:t') ==# 'PULLREQ_EDITMSG'
    setlocal formatoptions-=t " Don't add line breaks to wrapped lines
    setlocal wrap
endif

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal formatoptions< wrap<'
