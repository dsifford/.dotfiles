setlocal breakat=\  " preserve trailing ws
setlocal linebreak
setlocal wrap

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal breakat< linebreak< wrap<'
