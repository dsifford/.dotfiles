scriptencoding utf8
filetype plugin indent on

source ~/.vim/plugins.vimrc

" Options: {{{1
colorscheme dracula

set autowrite             " Automatically save before commands like :next and :make
set clipboard=unnamedplus " Use system clipboard
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

set completeopt =menuone  " Use the popup menu also when there is only one match
set completeopt+=noinsert " Do not insert any text for a match until the user selects a match from the menu
set completeopt+=noselect " Do not select a match in the menu, force the user to select one from the menu

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

let g:mapleader = ' '
let g:maplocalleader = ','

let g:tex_flavor = 'latex' " Never use plaintex flavor

if has('nvim')
    set inccommand=split
endif
"}}}1
" Plugin Settings: {{{1
" Airline: {{{2

let g:airline#extensions#ale#enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#fnamemod = ':t'

if !exists('g:airline_symbols')
    let g:airline_symbols = {
        \ 'readonly': '⛔',
        \}
endif

"}}}2
" ALE: {{{2

let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1

let g:ale_linter_aliases = {'typescriptreact': 'typescript'}

let g:ale_javascript_prettier_options = '--config-precedence prefer-file --single-quote --trailing-comma es5 --tab-width 4 --prose-wrap always'

let g:airline#extensions#ale#enabled = 1

nmap          <Leader>f <Plug>(ale_fix)
nmap <silent> <C-k>     <Plug>(ale_previous_wrap)
nmap <silent> <C-j>     <Plug>(ale_next_wrap)

nmap <silent> K         <Plug>(ale_hover)
nmap <silent> gd        <Plug>(ale_go_to_definition)
nmap <silent> gr        <Plug>(ale_find_references)

" TODO: Waiting for feature support
" nnoremap <silent> gs        :call LanguageClient_textDocument_documentSymbol()<CR>
" nnoremap <silent> gS        :call LanguageClient_workspace_symbol()<CR>
" nnoremap <silent> <F2>      :call LanguageClient_textDocument_rename()<CR>

"}}}2
" Auto Pairs: {{{2

" Disable toggle keybinding
let g:AutoPairsShortcutToggle = ''

"}}}2
" Colorizer: {{{2

let g:colorizer_auto_filetype='css,scss'
let g:colorizer_colornames = 0

"}}}2
" EasyAlign: {{{2

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(LiveEasyAlign)

"}}}2
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

augroup emmet_vim
    autocmd!
    autocmd FileType html,xml,markdown,css,scss,sass,tsx EmmetInstall
augroup END

"}}}2
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

command! GFiles call fzf#run(fzf#wrap({ 'source': 'GFiles', 'options': '-m --no-sort' }))

" nnoremap <A-p> :Files<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-b> :Buffers<CR>
" Grep word under cursor
nnoremap <silent> <Leader>r :Rg <C-R><C-W><CR>
nnoremap <silent> <A-p> <Cmd>call fzf#run(fzf#wrap({ 'source': 'fd -t f . ' . expand('%:h') }))<CR>


augroup dsifford_fzf
    autocmd!
    autocmd  FileType fzf set laststatus=0
                \| autocmd BufLeave <buffer> set laststatus=2
augroup END

"}}}2
" NCM2: {{{2

" Cycle next and prev completions
inoremap <expr> <Tab>   pumvisible() ? '<C-n>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'

" Select completion item with <CR>
inoremap <silent> <expr> <CR> (
        \ (pumvisible() && empty(v:completed_item)) ? '<C-y><CR>' :
        \ (!empty(v:completed_item)                 ? ncm2_ultisnips#expand_or('', 'n') :
        \ '<CR>' )
    \)

augroup dsifford_ncm2
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

" }}}2
" NERDCommenter: {{{2

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

let g:NERDCustomDelimiters = {
            \ 'typescript': { 'left': '//', 'leftAlt': '/**', 'rightAlt': '*/' },
            \ 'typescriptreact': { 'left': '//', 'leftAlt': '/**', 'rightAlt': '*/' },
            \}

" Toggle comment with Ctrl+/
nmap <silent> <C-_> <Plug>NERDCommenterToggle
vmap <silent> <C-_> <Plug>NERDCommenterToggle
imap <silent> <C-_> <Esc><C-_>

"}}}2
" Netrw: {{{2

let g:netrw_alto = 0
let g:netrw_banner = 0
let g:netrw_home = stdpath('cache')
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_preview = 1

" Toggle Netrw window
noremap <silent> <expr> <C-\> &ft ==# 'netrw' ? ':q<CR>' : ':Vexplore!<CR>'

"}}}2
" Polyglot: {{{2

let g:polyglot_disabled = [
            \ 'latex',
            \ 'php',
            \ 'scss',
            \ 'typescript',
            \ 'yaml',
            \]

"}}}2
" Scriptease: {{{2

" Show syntax groups under cursor
nmap <silent> <Leader>s <Plug>ScripteaseSynnames

"}}}2
" UltiSnips: {{{2

" FIXME: This still needs tweaking
let g:UltiSnipsEditSplit                = 'tabdo'
let g:UltiSnipsEnableSnipMate           = 0
let g:UltiSnipsExpandTrigger            = '<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpBackwardTrigger      = '<S-Tab>'
let g:UltiSnipsJumpForwardTrigger       = '<Tab>'
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsSnippetDirectories       = [ $HOME.'/.vim/UltiSnips' ]

imap <expr> <c-u> ncm2_ultisnips#expand_or('<Tab>')
smap <c-u> <Plug>(ultisnips_expand)

"}}}2
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

augroup dsifford_vimtex
    autocmd!
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

nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<CR>

"}}}2
" Vim Which Key: {{{2

nnoremap <silent> <Leader>      :<C-u>WhichKey '<Space>'<CR>
nnoremap <silent> <LocalLeader> :<C-u>WhichKey  ','<CR>

" }}}2
"}}}1
" Commands: {{{1

command! Reload source $MYVIMRC
command! Vimrc  vsplit ~/.dotfiles/vim/.vimrc

command! ReloadSyntax call vimrc#ReloadSyntax()
command! ZoomToggle   call vimrc#ZoomToggle()

"}}}1
" Mappings: {{{1

nnoremap Y  y$
nnoremap <silent> <Leader>l :set list!<CR>
nnoremap <silent> <Leader><Leader>l :set relativenumber!<CR>

" Make j and k move through soft line breaks
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Toggle fold
nnoremap <silent>         <CR> :pc <Bar> :if &foldenable <Bar> :exe ':silent! normal za\r' <Bar> :endif<CR>
" Toggle window fullscreen
nnoremap <silent> <Leader><CR> :ZoomToggle<CR>

" Search project with ripgrep
nnoremap <Leader>/ :Rg<Space>

nnoremap ZA :confirm wqall<CR>

" Open vimrc with F12
nnoremap <F12> :Vimrc<CR>

"}}}1
" Autocommands: {{{1

augroup dsifford_misc
    autocmd!

    " Toggle quickfix and preview window with <Esc>
    autocmd BufEnter * if &ft ==# 'qf' || &previewwindow | nnoremap <buffer><silent> <Esc> :quit<CR> | endif

    " Turn on cursorline for preview window
    autocmd BufEnter * if &previewwindow | setlocal cursorline | endif

    " Flush the screen's buffer on exit
    autocmd VimLeave * :!clear

    " Don't add comment when newline added with o or O for any filetype
    autocmd FileType * set formatoptions-=o | set formatoptions+=r

    " FIXME: Pending the fix to php syntax
    " Fixes issues with PHP and other languages changing global foldmethod
    autocmd BufLeave * set foldmethod=manual
    autocmd BufEnter *.php setlocal foldmethod=syntax
augroup END

" FIXME: This is possible using an nvim syntax group extension
augroup dsifford_diff_cursorline
    autocmd!

    autocmd FilterWritePost * if &diff | set cursorline | endif
    autocmd BufEnter * if &diff | set cursorline | endif
augroup END

"}}}1

" vim: set fdm=marker:
