if expand('%:t') ==# 'PULLREQ_EDITMSG'
    setlocal wrap
    setlocal formatoptions-=t " Don't add line breaks to wrapped lines
endif
