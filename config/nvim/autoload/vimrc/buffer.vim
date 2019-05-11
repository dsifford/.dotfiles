" Checks to see if <Tab> should insert a tab character or trigger completion.
" Returns v:true if...
"    - the character before the cursor is whitespace
"    OR
"    - the cursor is at column 1
func! vimrc#buffer#should_insert_tab() abort
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1] =~? '\s'
endfunc

" vim: set fdm=indent fdn=1:
