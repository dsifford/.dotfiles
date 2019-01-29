func! airline#extensions#tabline#formatters#indexfmt#format(bufnr, buffers)
    if getbufvar(a:bufnr, '&buftype') ==# 'terminal'
        return '~'
    elseif fnamemodify(bufname(a:bufnr), ':t:r') ==# 'index'
        return fnamemodify(bufname(a:bufnr), ':p:h:t')
    else
        return fnamemodify(bufname(a:bufnr), ':t')
    endif
endfunc
