" inoremap expression for handling the tab key
func! vimrc#buffer#handle_tab()
  if pumvisible()
    " If popup menu is visible, go to the next completion item.
    return "\<C-n>"
  endif

  let l:col = col('.') - 1
  if l:col == 0 || getline('.')[l:col - 1] =~? '\s'
    " If we're on column 1 or there's whitespace before the cursor, insert a regular tab
    return "\<TAB>"
  endif

  " Otherwise, let deoplete handle.
  return deoplete#manual_complete()
endfunc

" vim: set fdm=indent fdn=1:
