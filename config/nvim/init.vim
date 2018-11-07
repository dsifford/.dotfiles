set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath

augroup dsifford
    autocmd!
augroup END

source ~/.vimrc
