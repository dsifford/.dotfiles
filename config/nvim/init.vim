" Initialization: {{{

scriptencoding utf8
filetype plugin indent on

augroup dsifford
  autocmd!
augroup END

runtime plugins.vimrc

if has('mac')
  runtime mac.vimrc
endif

" }}}
" Options: {{{

set autowrite             " Automatically save before commands like :next and :make
set clipboard=unnamedplus " Use system clipboard
set cursorline            " Highlight the cursor line
set foldlevelstart=99     " Default to no folds closed on new buffers
set foldmethod=syntax     " Fold using syntax by default
set hidden                " Use hidden buffers liberally
set history=500           " Truncate history at 200 lines
set ignorecase            " Required for proper smartcase functionality
set lazyredraw            " Improves perf under some conditions
set nowrap                " Disable line wrapping
set noshowmode            " Dont show mode in the command line -- using Airline for that
set number                " Show line numbers
set pastetoggle=<F2>      " Toggle paste mode with F2
set scrolloff=1           " Minimum # of lines to keep above and below cursor
set shada=                " Don't use a shada.
set shiftround            " Round indents to nearest indent size when using < or >
set smartcase             " Case insensitive unless typing with caps
set smarttab              " sw at the start of the line, sts everywhere else
set splitbelow            " Open horizontal splits below current buffer
set splitright            " Open vertical splits to the right of current buffer
set termguicolors         " Force GUI colors in terminals
set timeoutlen=250        " Time in milliseconds to wait for a mapped sequence to complete.
set updatetime=100        " Time in milliseconds until swap file is updated
set virtualedit=block     " Allow cursor to be placed in virtual positions when in visual block mode
set wildoptions+=pum      " Display the completion matches using a popupmenu
set winaltkeys=no         " Allows all ALT combinations to be mapped

set completeopt =menu     " Use a popup menu to show the possible completions
set completeopt+=menuone  " Use the popup menu also when there is only one match
set completeopt+=noinsert " Do not insert any text for a match until the user selects a match from the menu
set completeopt+=noselect " Do not select a match in the menu, force the user to select one from the menu

set formatoptions+=r      " DO insert the current comment leader after hitting <Enter> in Insert mode.
set formatoptions-=o      " DO NOT insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set formatoptions-=t      " DO NOT automatically wrap non-comment lines when textwidth is set.

set listchars =tab:▸\ ,
set listchars+=eol:¬
set listchars+=space:·

set shortmess+=c          " Don't give ins-completion-menu messages
set shortmess+=I          " Don't show the intro message when starting vim

set wildignore =tags
set wildignore+=*.o
set wildignore+=*.py?

" Tabs = 4 spaces by default
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Custom foldtext
set foldtext=vimrc#folds#foldtext()

let g:mapleader      = "\<Space>"
let g:maplocalleader = ','

let g:tex_flavor = 'latex' " Never use plaintex flavor

let g:which_key_map = {}   " Mapping dictionary for vim-which-key

if has('nvim')
  set inccommand=split
endif

colorscheme dracula
hi clear CursorLine " disables line highlight, but keeps `CursorLineNr`

" }}}
" Plugin Settings: {{{
" Airline: {{{2

let g:airline_section_c = '%{vimrc#window#statusline()}'

let g:airline_skip_empty_sections = 1

let g:airline#extensions#ale#enabled         = 1
let g:airline#extensions#ale#checking_symbol = '' " Don't show warnings for non-warnings in ale

let g:airline#extensions#tabline#enabled       = 1
let g:airline#extensions#tabline#show_buffers  = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tab_nr_type   = 1
let g:airline#extensions#tabline#formatter     = 'indexfmt'
let g:airline#extensions#tabline#show_tab_nr   = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {
  \  'readonly': '⛔',
  \}
endif

" }}}2
" ALE: {{{2

let g:which_key_map.a = { 'name': '+ALE' }

let g:ale_completion_enabled = 1
let g:ale_linters_explicit   = 1
let g:ale_lsp_suggestions    = 1
let g:ale_virtualtext_cursor = 1

let g:ale_sign_error   = has('mac') ? 'x' : '⮿'
let g:ale_sign_warning = has('mac') ? '!' : '⚠'
let g:ale_sign_info    = has('mac') ? '?' : '🛈'

let g:ale_javascript_prettier_options = '--config-precedence=prefer-file --prose-wrap=preserve --single-quote --tab-width=4 --trailing-comma=es5'

let g:which_key_map.f = 'ALE: Quick fix'
nnoremap <silent> <Leader>f <Cmd>exec 'ALEFix ' . (index(get(b:, 'ale_fixers', []), get(b:, 'ale_quick_fixer', '')) >= 0 ? b:ale_quick_fixer : '')<CR>

let g:which_key_map.F = 'ALE: Fix all'
nnoremap <silent> <Leader>F <Cmd>ALEFix<CR>

nnoremap <silent> <Leader>k <Cmd>ALEDetail<CR>

nnoremap <silent> gd <Cmd>ALEGoToDefinition<CR>
nnoremap <silent> gD <Cmd>ALEGoToDefinition -tab<CR>
nnoremap <silent> gr <Cmd>ALEFindReferences -relative<CR>

nnoremap <silent> <F2> <Cmd>ALERename<CR>

" Jump to next error/warning/info from linter/language server
nnoremap <silent> <C-k> <Cmd>ALEPreviousWrap<CR>
nnoremap <silent> <C-j> <Cmd>ALENextWrap<CR>

let g:which_key_map.a.g = {
\  'name': '+Goto',
\  's': ['ALEGoToDefinition -split', 'Definition in Split'],
\  'v': ['ALEGoToDefinition -vsplit', 'Definition in VSplit'],
\  'S': ['ALEGoToTypeDefinition -split', 'Type Definition in Split'],
\  'V': ['ALEGoToTypeDefinition -vsplit', 'Type Definition in VSplit'],
\}

augroup dsifford
  " Set keywordprg for language server filetypes
  let s:ft_keywordprg_ale_hover = [
  \  'javascript',
  \  'python',
  \  'rust',
  \  'typescript',
  \  'typescriptreact'
  \]
  autocmd BufNewFile,BufRead *
    \ if index(s:ft_keywordprg_ale_hover, &ft) >= 0
    \|  setlocal keywordprg=:call\ ale#hover#ShowAtCursor()
    \|endif

  " Disable for certain buffers
  autocmd BufEnter */node_modules/* ALEDisableBuffer
augroup END

" }}}2
" Auto Pairs: {{{2

" Disable toggle keybinding
let g:AutoPairsShortcutToggle = ''

" }}}2
" Colorizer: {{{2

let g:colorizer_auto_filetype='css,scss'
let g:colorizer_colornames = 0

" }}}2
" Deoplete: {{{2

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('smart_case', v:true)

inoremap <silent><expr> <Tab> vimrc#buffer#handle_tab()

inoremap <silent> <S-Tab> <C-p>

" }}}2
" EasyAlign: {{{2

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(LiveEasyAlign)

" }}}2
" Emmet: {{{2

let g:user_emmet_leader_key     = '<C-e>'
let g:user_emmet_expandabbr_key = '<C-e><C-e>'
let g:user_emmet_next_key       = '<C-e>j'
let g:user_emmet_prev_key       = '<C-e>k'

let g:user_emmet_settings = {
\  'markdown' : {
\    'extends' : 'html',
\  },
\}

augroup dsifford
  autocmd FileType html,xml,markdown,css,scss,sass,typescriptreact EmmetInstall
augroup END

" }}}2
" Fzf: {{{2

let g:fzf_action = {
\  'ctrl-t': 'tab split',
\  'ctrl-o': 'split',
\  'ctrl-v': 'vsplit',
\}

func! s:CompleteRg(arg_lead, line, pos)
  let l:args = join(split(a:line)[1:])
  return systemlist('get_completions rg ' . l:args)
endfunc

" Add support for ripgrep
" TODO: better arg parsing
command! -bang -complete=customlist,s:CompleteRg -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case ' . <q-args>,
  \   1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0
  \ )

" Search for all todo-style comments in the current working directory
command! -complete=customlist,s:CompleteRg -nargs=* TODOs
  \ call fzf#vim#grep(
  \     'rg --column --line-number --no-heading --color=always --smart-case ' . <q-args> . ' "\b(FIXME|HACK|TODO|XXX)\b:"',
  \     1,
  \     fzf#vim#with_preview('up:50%'),
  \     1
  \ )

" List files relative to pwd
nnoremap <C-p> <Cmd>call fzf#run(fzf#wrap({ 'source': 'fd --hidden --type file --exclude ".git/"', 'options': '-m' }))<CR>

" List files relative to directory of current file
nnoremap <M-p> <Cmd>call fzf#run(fzf#wrap({ 'source': 'fd . --hidden --type file --exclude ".git/" ' . expand('%:h'), 'options': '-m' }))<CR>

" }}}2
" }}}2
" Matchup: {{{2

let g:matchup_transmute_enabled = 1

nnoremap <silent> <leader>w <Cmd>MatchupWhereAmI??<CR>

" }}}2
" Netrw: {{{2

let g:netrw_alto           = 0
let g:netrw_banner         = 0
let g:netrw_browsex_viewer = $BROWSER " gx when cursor is over a link will open the link in $BROWSER
let g:netrw_home           = stdpath('cache')
let g:netrw_preview        = 1        " Preview window is a vertical split
let g:netrw_special_syntax = 1

" }}}2
" Scriptease: {{{2

" Show syntax groups under cursor
nmap <silent> <Leader>S <Plug>ScripteaseSynnames

" }}}2
" Sneak: {{{2

let g:sneak#label      = 1
let g:sneak#s_next     = 1
let g:sneak#use_ic_scs = 1

" }}}2
" TComment: {{{2

let g:tcomment_mapleader2 = ''

let g:tcomment#filetype#guess_php = 'php'

let g:tcomment#block2_fmt_c = extend(g:tcomment#block2_fmt_c, {
\  'commentstring': '/** %s */',
\})

call tcomment#type#Define('jsonc', '// %s')

augroup dsifford
  autocmd FileType javascript,php,typescript,typescriptreact ++once
    \ call tcomment#type#Define( expand('<amatch>:r') . '_block', g:tcomment#block2_fmt_c)
    \|call tcomment#type#Define( expand('<amatch>:r') . '_inline', tcomment#GetLineC('/** %s */'))
augroup END

" }}}2
" Tree-Sitter: {{{2
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  playground = {
    enable = true,
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
}
EOF
" }}}2
" UltiSnips: {{{2

let g:UltiSnipsEditSplit           = 'tabdo'
let g:UltiSnipsExpandTrigger       = '<M-j>'
let g:UltiSnipsJumpForwardTrigger  = '<M-n>'
let g:UltiSnipsJumpBackwardTrigger = '<M-b>'

" }}}2
" Vim Textobject User: {{{2

" Text object for block comments
call textobj#user#plugin('dsifford', {
\  'block-comment': {
\    'pattern': ['\/\*', '\*\/'],
\    'region-type': 'V',
\    'select-a': 'ac',
\  }
\})

" }}}2
" Vim Tmux Navigator: {{{2

" Disables built-in mappings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-h> <Cmd>TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> <Cmd>TmuxNavigateDown<CR>
nnoremap <silent> <M-k> <Cmd>TmuxNavigateUp<CR>
nnoremap <silent> <M-l> <Cmd>TmuxNavigateRight<CR>

" }}}2
" Vim Which Key: {{{2

call which_key#register('<Space>', 'g:which_key_map')

nnoremap <silent> <Leader> <Cmd>silent! WhichKey '<Space>'<CR>
vnoremap <silent> <Leader> <Cmd>silent! WhichKeyVisual '<Space>'<CR>

nnoremap <silent> <LocalLeader> <Cmd>silent! WhichKey ','<CR>
vnoremap <silent> <LocalLeader> <Cmd>silent! WhichKeyVisual ','<CR>

" }}}2
" }}}
" Commands: {{{

command! Reload source $MYVIMRC

" }}}
" Mappings: {{{

" Yank from cursor position to end of line
nnoremap Y  y$

" Make j and k move through soft line breaks
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Use <PageUp> and <PageDown> to jump lists
nnoremap <silent> <PageUp>   <Cmd>call vimrc#lists#smart_jump(-1)<CR>
nnoremap <silent> <PageDown> <Cmd>call vimrc#lists#smart_jump(1)<CR>

" Clear hlsearch
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Toggle fold
nnoremap <silent> <CR> <Cmd>pc <Bar> :if &foldenable <Bar> :exe ':silent! normal za\r' <Bar> :endif<CR>

" Open vimrc with F12
noremap <silent> <F12> <Cmd>call vimrc#toggle_edit_ftplugin()<CR>

" Select the next/prev matches while performing a search
cnoremap <C-j> <C-g>
cnoremap <C-k> <C-t>

" Alt+ and Alt- increases and decreases foldlevel respectively
nnoremap <M--> zr
nnoremap <M-=> zm

" Remap semicolon to colon
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Enumerate vertical column of numbers
vnoremap ++ g<C-a>

" }}}
" Leader Mappings: {{{

let g:which_key_map.s = { 'name': '+settings' }
nnoremap <silent> <Leader>sl <Cmd>set list!<CR>
nnoremap <silent> <Leader>st <Cmd>set textwidth=
nnoremap <silent> <Leader>sw <Cmd>set wrap! linebreak!<CR>

let g:which_key_map.z = {
\   'name': '+folds',
\   'f': ['vimrc#folds#toggle_first_level()', 'Toggle first-level folds'],
\   '/': ['vimrc#folds#fold_lines_matching()', 'Fold all lines beginning with word'],
\}

let g:which_key_map['<CR>'] = 'Toggle buffer fullscreen'
nnoremap <silent> <Leader><Enter> <Cmd>call vimrc#window#zoom_toggle()<CR>

let g:which_key_map['/'] = 'Search project with ripgrep'
nnoremap <Leader>/ :Rg<Space>

" }}}
" Autocommands: {{{

augroup dsifford
  " Check to see if the current buffer has changes from another program.
  " If so, reload the changes.
  autocmd BufEnter,FocusGained * :checktime

  " Toggle quickfix and preview window with <Esc>
  autocmd BufEnter *
    \ if &ft ==# 'qf' || &previewwindow
    \|  nnoremap <buffer><silent> <Esc> <Cmd>quit<CR>
    \|endif

  " Disable syntax on files larger than 1_000_000 bytes
  autocmd BufEnter,BufReadPre *
    \ if getfsize(expand("%")) > 1000000
    \|  syntax off
    \|endif
  " Re-enable syntax when leaving large files
  autocmd BufWinLeave *
    \ if getfsize(expand("%")) > 1000000 && type(v:exiting) == 7
    \|  syntax on
    \|  hi clear CursorLine
    \|endif

  " Prevent any global or plugin ftplugin from manipulating formatoptions
  autocmd FileType * setlocal formatoptions< textwidth<

  " Quit if the last remaining window is a quickfix or info window
  autocmd WinEnter *
    \ if winnr('$') == 1 && index(['quickfix', 'nofile'], &buftype) != -1
    \|  quit
    \|endif

  " Flush the screen's buffer on exit
  autocmd VimLeave * :!clear
augroup END

" }}}
