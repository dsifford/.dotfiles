setlocal breakindent
setlocal conceallevel=2
setlocal linebreak
setlocal textwidth=80
setlocal wrap

nmap <buffer> <silent> <LocalLeader>h <Cmd>exec 'set conceallevel=' . (&conceallevel ? 0 : 2)<CR>

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'setlocal breakindent< conceallevel< linebreak< textwidth< wrap<',
    \ 'nmapclear <buffer>',
    \)
