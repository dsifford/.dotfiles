" Initialization: {{{

scriptencoding utf8
filetype plugin indent on

augroup dsifford
    autocmd!
augroup END

let $MYVIMHOME=fnamemodify($MYVIMRC, ':p:h')

set runtimepath-=~/.config/nvim/after " Prevent this from being sourced twice due to symlink
set runtimepath+=$MYVIMHOME/after

source $MYVIMHOME/plugins.vimrc

" }}}
" Options: {{{

set autowrite             " Automatically save before commands like :next and :make
set clipboard=unnamedplus " Use system clipboard
set cursorline            " Highlight the cursor line
set foldlevelstart=99     " Default to no folds closed on new buffers
set hidden                " Use hidden buffers liberally
set history=200           " Truncate history at 200 lines
set ignorecase            " Required for proper smartcase functionality
set lazyredraw            " Improves perf under some conditions
set nowrap                " Disable line wrapping
set noshowmode            " Dont show mode in the command line -- using Airline for that
set number                " Show line numbers
set pastetoggle=<F2>      " Toggle paste mode with F2
set shiftround            " Round indents to nearest indent size when using < or >
set shortmess+=c          " Don't give ins-completion-menu messages
set smartcase             " Case insensitive unless typing with caps
set smarttab              " sw at the start of the line, sts everywhere else
set splitbelow            " Open horizontal splits below current buffer
set splitright            " Open vertical splits to the right of current buffer
set termguicolors         " Force GUI colors in terminals
set timeoutlen=500        " Time in milliseconds to wait for a mapped sequence to complete.
set virtualedit=block     " Allow cursor to be placed in virtual positions when in visual block mode
set winaltkeys=no         " Allows all ALT combinations to be mapped

set completeopt =menu     " Use a popup menu to show the possible completions
set completeopt+=menuone  " Use the popup menu also when there is only one match
set completeopt+=noinsert " Do not insert any text for a match until the user selects a match from the menu
set completeopt+=noselect " Do not select a match in the menu, force the user to select one from the menu
set completeopt+=preview  " Show extra information about the completion in the preview window

set listchars =tab:▸\ ,
set listchars+=eol:¬
set listchars+=space:·

set wildignore =tags
set wildignore+=*.o
set wildignore+=*.py?

" Tabs = 4 spaces by default
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Custom foldtext (TODO: Improve this)
set foldtext=vimrc#foldtext()

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

let g:dracula_cursorline = 0 " Disable cursorline background highlight
let g:tex_flavor = 'latex'   " Never use plaintex flavor
let g:which_key_map = {}     " Mapping dictionary for vim-which-key

if has('nvim')
    set inccommand=split
endif

colorscheme dracula

hi clear CursorLine  " disables line highlight, but keeps `CursorLineNr`

" }}}
" Plugin Settings: {{{
" Airline: {{{2

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#formatter = 'indexfmt'
let g:airline#extensions#tabline#show_tab_nr = 0

if !exists('g:airline_symbols')
    let g:airline_symbols = {
        \ 'readonly': '⛔',
        \}
endif

" }}}2
" ALE: {{{2

let g:airline#extensions#ale#enabled = 1

let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_virtualtext_cursor = 1

let g:ale_sign_error   = has('mac') ? 'x' : '⮿'
let g:ale_sign_warning = has('mac') ? '!' : '⚠'
let g:ale_sign_info    = has('mac') ? '?' : '🛈'

let g:ale_linter_aliases = {'typescriptreact': 'typescript'}

let g:ale_javascript_prettier_options = '--config-precedence=prefer-file --prose-wrap=always --single-quote --tab-width=4 --trailing-comma=es5'

nnoremap <silent> <Leader>f :ALEFix<CR>
nnoremap <silent> <Leader>k :ALEDetail<CR>

nnoremap <silent> <C-k> :ALEPreviousWrap<CR>
nnoremap <silent> <C-j> :ALENextWrap<CR>

nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> gD :ALEGoToDefinitionInTab<CR>
nnoremap <silent> gr :ALEFindReferences<CR>

augroup dsifford
    " Set keywordprg for language server filetypes
    let s:ft_keywordprg_ale_hover = [
        \ 'javascript',
        \ 'python',
        \ 'rust',
        \ 'typescript',
        \ 'typescript.tsx',
        \ ]
    autocmd BufNewFile,BufRead *
                \ if index(s:ft_keywordprg_ale_hover, &ft) >= 0                                                   |
                \     setlocal keywordprg=:call\ ale#hover#Show(bufnr(''),\ getcurpos()[1],\ getcurpos()[2],\ {}) |
                \ endif

    " Disable for certain buffers
    autocmd BufEnter */node_modules/* ALEDisableBuffer
augroup END

" TODO: Waiting for feature support
" nnoremap <silent> gs        :call LanguageClient_textDocument_documentSymbol()<CR>
" nnoremap <silent> gS        :call LanguageClient_workspace_symbol()<CR>
" nnoremap <silent> <F2>      :call LanguageClient_textDocument_rename()<CR>

" }}}2
" Auto Pairs: {{{2

" Disable toggle keybinding
let g:AutoPairsShortcutToggle = ''

" }}}2
" Colorizer: {{{2

let g:colorizer_auto_filetype='css,scss'
let g:colorizer_colornames = 0

" }}}2
" EasyAlign: {{{2

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(LiveEasyAlign)

" }}}2
" Emmet: {{{2

let g:user_emmet_leader_key='<C-e>'

imap <C-e><C-e> <Plug>(emmet-expand-abbr)
imap <C-e><C-]> <Plug>(emmet-move-next)
imap <C-e><C-[> <Plug>(emmet-move-prev)

let g:user_emmet_settings = {
\  'markdown' : {
\      'extends' : 'html',
\  },
\}

augroup dsifford
    autocmd FileType html,xml,markdown,css,scss,sass,tsx EmmetInstall
augroup END

" }}}2
" Fzf: {{{2

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-o': 'split',
            \ 'ctrl-v': 'vsplit' }

function! s:CompleteRg(arg_lead, line, pos)
    let l:args = join(split(a:line)[1:])
    return systemlist('get_completions rg ' . l:args)
endfunction

" Add support for ripgrep
command! -bang -complete=customlist,s:CompleteRg -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case ' . <q-args> . ' ' . system('git rev-parse --show-toplevel 2>/dev/null || pwd'), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

command! GFiles call fzf#run(fzf#wrap({ 'source': 'GFiles', 'options': '-m' }))

nnoremap <C-p> :GFiles<CR>
nnoremap <C-b> :Buffers<CR>

nnoremap <silent> <M-p> :call fzf#run(fzf#wrap({ 'source': 'fd -t f . ' . expand('%:h') }))<CR>

let g:which_key_map.r = 'Grep word under cursor'
nnoremap <silent> <Leader>r :Rg <C-R><C-W><CR>


augroup dsifford
    autocmd  FileType fzf set laststatus=0
                \| autocmd BufLeave <buffer> set laststatus=2
augroup END

" }}}2
" MUcomplete: {{{2

let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['ulti', 'path', 'keyn']

" Expand Ultisnips with Enter key
inoremap <silent> <expr> <CR> mucomplete#ultisnips#expand_snippet('<CR>')

" }}}2
" Netrw: {{{2

let g:netrw_alto = 0
let g:netrw_banner = 0
let g:netrw_home = stdpath('cache')
let g:netrw_preview = 1

" Toggle Netrw window
noremap <silent> <C-\> <Cmd>vertical botright vsplit <Bar> normal -<CR>

augroup dsifford
    autocmd FileType netrw let g:netrw_list_hide = netrw_gitignore#Hide() . ',\.git,^\.\.\=\/'
    autocmd FileType netrw noremap <buffer> <silent> <C-\> <Cmd>q<CR>
augroup END

" }}}2
" Scriptease: {{{2

" Show syntax groups under cursor
nmap <silent> <Leader>s <Plug>ScripteaseSynnames

" }}}2
" Sneak: {{{2

let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

" }}}2
" TComment: {{{2

let g:tcomment_mapleader2 = ''
let g:tcomment#filetype#guess_php = 'php'

for s:t in [ 'php', 'typescript', 'javascript' ]
    call tcomment#type#Define( s:t . '_block', g:tcomment#block2_fmt_c)
endfor

" }}}2
" UltiSnips: {{{2

let g:UltiSnipsEditSplit           = 'tabdo'
let g:UltiSnipsExpandTrigger       = '<M-j>'
let g:UltiSnipsJumpForwardTrigger  = '<M-j>'
let g:UltiSnipsJumpBackwardTrigger = '<M-k>'
let g:UltiSnipsSnippetDirectories  = [ $HOME.'/.vim/UltiSnips' ]

" }}}2
" Vimtex: {{{2

let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim',
    \ 'background' : 1,
    \ 'build_dir' : 'build',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

augroup dsifford
    autocmd Filetype tex call ncm2#register_source({
            \ 'name': 'vimtex',
            \ 'priority': 8,
            \ 'scope': ['tex'],
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
augroup END

if executable('skimpdf')
    let g:vimtex_view_general_viewer = 'skim'
    let g:vimtex_view_method = 'skim'
endif

let g:vimtex_compiler_progname = 'nvr'

" }}}2
" Vim Tmux Navigator: {{{2

" Disables built-in mappings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>
nnoremap <silent> <M-\> :TmuxNavigatePrevious<CR>

" }}}2
" Vim Which Key: {{{2

call which_key#register('<Space>', 'g:which_key_map')

nnoremap <silent> <Leader> :<C-u>silent! WhichKey '<Space>'<CR>
vnoremap <silent> <Leader> :<C-u>silent! WhichKeyVisual '<Space>'<CR>

nnoremap <silent> <LocalLeader> :<C-u>silent! WhichKey ','<CR>
vnoremap <silent> <LocalLeader> :<C-u>silent! WhichKeyVisual ','<CR>

let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'h' : ['Startify'  , 'home-buffer']     ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ '?' : ['Buffers'   , 'fzf-buffer']      ,
      \ }

" }}}2
" }}}
" Commands: {{{

command! Reload source $MYVIMRC
command! ReloadSyntax call vimrc#ReloadSyntax()

" }}}
" Mappings: {{{

" Yank from cursor position to end of line
nnoremap Y  y$

" Make j and k move through soft line breaks
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Toggle fold
nnoremap <silent> <CR> :pc <Bar> :if &foldenable <Bar> :exe ':silent! normal za\r' <Bar> :endif<CR>

" Save and quit all
nnoremap ZA :confirm wqall<CR>

" Open vimrc with F12
noremap <silent> <F12> :call vimrc#toggleEditVimrc()<CR>

" Select the next/prev matches while performing a search
cnoremap <C-j> <C-g>
cnoremap <C-k> <C-t>

" Alt+ and Alt- increases and decreases foldlevel respectively
nnoremap <M--> zr
nnoremap <M-=> zm

" FIXME: Trying this out for a little bit
" Remap semicolon to colon
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

"

" }}}
" Leader Mappings: {{{

let g:which_key_map.l = { 'name': '+settings' }
nnoremap <silent> <Leader>ll :set list!<CR>
nnoremap <silent> <Leader><Leader>ln :set relativenumber!<CR>

let g:which_key_map.z = { 'name': '+folds' }

let g:which_key_map.z.f = 'Toggle first-level folds in buffer'
nnoremap <silent> <Leader>zf <Cmd>call vimrc#folds#ToggleFirstLevel()<CR>

let g:which_key_map.z['/'] = 'Fold all lines beginning with word'
nnoremap <silent> <Leader>z/ <Cmd>call vimrc#folds#FoldLinesMatching()<CR>

let g:which_key_map['<Enter>'] = 'Toggle buffer fullscreen'
nnoremap <silent> <Leader><Enter> :call vimrc#ZoomToggle()<CR>

let g:which_key_map['/'] = 'Search project with ripgrep'
nnoremap <Leader>/ :Rg<Space>

" }}}
" Autocommands: {{{

augroup dsifford
    " Toggle quickfix and preview window with <Esc>
    autocmd BufEnter * if &ft ==# 'qf' || &previewwindow | nnoremap <buffer><silent> <Esc> :quit<CR> | endif

    " Turn on cursorline for preview window
    autocmd BufEnter * if &previewwindow | setlocal cursorline | endif

    " Check to see if the current buffer has changes from another program. If
    " so, reload the changes.
    autocmd FocusGained,BufEnter * :checktime

    " Flush the screen's buffer on exit
    autocmd VimLeave * :!clear

    " Don't add comment when newline added with o or O for any filetype
    autocmd FileType * set formatoptions-=o | set formatoptions+=r

    " Sets the foldlevel from 99 (set above) to the number of the highest fold
    " in the buffer
    autocmd BufRead * :normal zr

    " Set CursorLine to be underlined while in a diff
    autocmd FilterWritePost * if &diff | hi CursorLine gui=underline | endif
    autocmd BufEnter * if &diff | hi CursorLine gui=underline | endif
augroup END

" }}}

" vim: set fdm=marker:
