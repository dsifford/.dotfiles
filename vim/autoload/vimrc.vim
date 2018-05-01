" Helper that unloads, reloads, and repaints syntax on demand
function! vimrc#ReloadSyntax()
    LanguageClientStop
    let l:current_file = expand('%:p')
    write
    Reload
    bdelete
    exec 'edit' l:current_file
    silent! LanguageClientStart
endfunction


" Zoom / Restore active window
function! vimrc#ZoomToggle()
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
