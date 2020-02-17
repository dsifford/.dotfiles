" Custom `foldtext` function.
func! vimrc#folds#foldtext() abort
    let l:line = getline(v:foldstart)
    let l:leading_whitespace = match(l:line, '\S') - 1
    let l:marks_count = len(v:folddashes) + 1
    if l:marks_count <= l:leading_whitespace
        return substitute(l:line, '^.\{' . l:marks_count . '}', '+' . v:folddashes, '')
    elseif l:leading_whitespace > 0
        return substitute(l:line, '^\s', '+', '')
    else
        return l:line
    endif
endfunc

" Folds all lines matching regex pattern entered in prompt.
func! vimrc#folds#fold_lines_matching()
  let l:pos = getpos('.')
  call inputsave()
  let l:word = input('Enter fold word: ')
  call inputrestore()
  exec 'g/^\s*' . l:word . '/normal zc'
  call setpos('.', l:pos)
endfunc

" Toggle fold/unfold at first fold level only.
func! vimrc#folds#toggle_first_level()
    normal! zR
    %foldc
endfunc

" vim: set fdm=indent fdn=1:
