setlocal foldlevel=99
setlocal foldmethod=indent

let b:ale_fixers = [
    \ 'prettier',
    \ ]

let b:ale_javascript_prettier_options = vimrc#merge_ale_options('ale_javascript_prettier_options', [
    \ '--tab-width=2',
    \])

let b:undo_ftplugin = vimrc#undo_ftplugin(
    \ 'setlocal foldlevel< foldmethod<',
    \ 'unlet b:ale_fixers b:ale_javascript_prettier_options'
    \)

" Necessary for whatever reason to make foldlevel actually work
call timer_start(100, { timer -> execute('normal zR') })
