setlocal breakindent
setlocal linebreak
setlocal wrap

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'setlocal breakindent< linebreak< wrap<',
    \)

