nmap <buffer> <silent> <Tab> gO

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'nmapclear <buffer>',
    \)
