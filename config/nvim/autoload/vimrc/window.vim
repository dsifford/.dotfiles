" If current filename is index.*, then set statusline to dir/index.*
func! vimrc#window#statusline()
    let l:filename = expand('%:t')
    if l:filename ==# ''
        return '[No Name]'
    elseif l:filename =~? '^index\.[a-z]*$'
        return expand('%:p:h:t') . '/' . l:filename
    else
        return l:filename
    endif
endfunc

" Zoom / Restore active window
func! vimrc#window#zoom_toggle()
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

" vim: set fdm=indent fdn=1:
