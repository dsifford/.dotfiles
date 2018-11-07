if &filetype !=# 'html'
    finish
endif

let b:ale_fixers = [
    \ 'prettier',
    \ ]
