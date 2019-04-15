" Smart jump to next error/warning or next position in quickfix of loclist
func! vimrc#buffer#smartJump(dir)
    if type(a:dir) != v:t_number
        echoerr 'vimrc#smartJump: dir argument must be a number'
        return
    endif
    let l:wininfo = getwininfo()
    if len(filter(l:wininfo, {idx, val -> val.quickfix})) > 0
        " quickfix is open
        try
            exec a:dir > 0 ? 'cnext' : 'cprev'
        catch
            exec a:dir > 0 ? 'cfirst' : 'clast'
        catch
        endtry
    elseif len(filter(l:wininfo, {idx, val -> val.loclist})) > 0
        " loclist is open
        try
            exec a:dir > 0 ? 'lnext' : 'lprev'
        catch
            exec a:dir > 0 ? 'lfirst' : 'llast'
        catch
        endtry
    else
        exec a:dir > 0 ? 'ALENextWrap' : 'ALEPreviousWrap'
    endif
endfunc
