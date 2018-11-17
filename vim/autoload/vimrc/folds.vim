
func! vimrc#folds#FoldLinesMatching()
  call inputsave()
  let l:word = input('Enter fold word: ')
  call inputrestore()
  exec 'g/^\s*' . l:word . '/normal zc'
endfunc

func! vimrc#folds#ToggleFirstLevel()
    if get(b:, 'foldstate', 1)
        %foldc
    else
        %foldo
    endif
    let b:foldstate=!get(b:, 'foldstate', 1)
endfunc
