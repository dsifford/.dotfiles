" Remove item under cursor
func! vimrc#lists#delete_item_at_cursor()
    if &filetype !=# 'qf'
        echoerr 'This function must only be called from the quickfix list or loclist'
        return
    endif
    let l:line = line('.')
    call setqflist(filter(getqflist(), {idx -> idx != l:line - 1}), 'r')
    exec 'cfirst ' l:line
endfunc

" Smart jump to next position in quickfix or loclist if either one is open.
func! vimrc#lists#smart_jump(dir)
    if type(a:dir) != v:t_number
        echoerr 'vimrc#smart_jump: dir argument must be a number'
        return
    endif
    if s:is_open('loclist')
        try
            exec a:dir > 0 ? 'lnext' : 'lprev'
        catch
            exec a:dir > 0 ? 'lfirst' : 'llast'
        catch
        endtry
    elseif s:is_open('quickfix')
        try
            exec a:dir > 0 ? 'cnext' : 'cprev'
        catch
            exec a:dir > 0 ? 'cfirst' : 'clast'
        catch
        endtry
    endif
endfunc

" Helper to check if quickfix or loclist is open in current window
func! s:is_open(win)
    for l:winid in gettabinfo()[tabpagenr()-1]['windows']
        for l:info in getwininfo(l:winid)
            if l:info[a:win]
                return v:true
            endif
        endfor
    endfor
    return v:false
endfunc

" vim: set fdm=indent fdn=1:
