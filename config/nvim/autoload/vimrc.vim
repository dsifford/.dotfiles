func! vimrc#toggleEditVimrc() abort
    if expand('%:t') ==# fnamemodify($MYVIMRC, ':t')
        w | bd
    else
        exec 'vert botright ' . float2nr(round(&columns * 0.75)) . 'vsplit $MYVIMRC'
    endif
endfunc

func! vimrc#foldtext() abort
    let line = getline(v:foldstart)
    return '+' . v:folddashes . ' ' . line
endfunc

func! vimrc#MergeALEOptions(key, list)
    func! s:opts_to_dict(list)
        let l:opts = {}
        for l:item in a:list
            let l:key = matchstr(l:item, '\(^[^=]*\)')
            if !empty(l:key) && !has_key(l:opts, l:key)
                let l:opts[l:key] = matchstr(l:item, '=.*')
            endif
        endfor
        return l:opts
    endfunc
    let l:globals = s:opts_to_dict(split(get(g:, a:key, [])))
    let l:options = s:opts_to_dict(a:list)
    for [l:k, l:v] in items(l:globals)
        if !has_key(l:options, l:k)
            let l:options[l:k] = l:v
        endif
    endfor
    return join(values(map(l:options, {k, v -> k . v})))
endfunc

" Helper that unloads, reloads, and repaints syntax on demand
func! vimrc#ReloadSyntax()
    let l:current_file = expand('%:p')
    write
    Reload
    bdelete
    exec 'edit' l:current_file
endfunc

" Zoom / Restore active window
func! vimrc#ZoomToggle()
    if exists('t:zoomed') && t:zoomed
        exec t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunc

" vim: set fdm=syntax:
