
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
func! vimrc#folds#foldLinesMatching()
  call inputsave()
  let l:word = input('Enter fold word: ')
  call inputrestore()
  exec 'g/^\s*' . l:word . '/normal zc'
endfunc

" Toggle fold/unfold at first fold level only.
func! vimrc#folds#toggleFirstLevel()
    if get(b:, 'foldstate', 1)
        %foldc
    else
        %foldo
    endif
    let b:foldstate=!get(b:, 'foldstate', 1)
endfunc
