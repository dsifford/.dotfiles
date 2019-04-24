setlocal foldlevel=99
setlocal foldmethod=indent

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
    \ . '| setlocal foldlevel< foldmethod<'

let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:ale_javascript_prettier_options = vimrc#merge_ale_options('ale_javascript_prettier_options', [
    \ '--tab-width=2',
    \])

" Necessary for whatever reason to make foldlevel actually work
call timer_start(100, { timer -> execute('normal zR') })
