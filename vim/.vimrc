scriptencoding utf8
filetype plugin indent on

source ~/.vim/plugins.vimrc

" Options: {{{1
colorscheme dracula

set autowrite                       " Automatically save before commands like :next and :make
set clipboard=unnamedplus           " Use system clipboard
set hidden                          " Use hidden buffers liberally
set history=200                     " Truncate history at 200 lines
set ignorecase                      " Required for proper smartcase functionality
set lazyredraw                      " Improves perf under some conditions
set listchars=tab:▸\ ,eol:¬,space:· " Symbols for whitespace when 'set list' enabled
set nowrap                          " Disable line wrapping
set noshowmode                      " Dont show mode in the command line -- using Airline for that
set number                          " Show line numbers
set pastetoggle=<F2>                " Toggle paste mode with F2
set shiftround                      " Round indents to nearest indent size when using < or >
set smartcase                       " Case insensitive unless typing with caps
set smarttab                        " sw at the start of the line, sts everywhere else
set splitbelow                      " Open horizontal splits below current buffer
set splitright                      " Open vertical splits to the right of current buffer
set termguicolors                   " Force GUI colors in terminals
set virtualedit=block               " Allow cursor to be placed in virtual positions when in visual block mode
set winaltkeys=no                   " Allows all ALT combinations to be mapped

" Tabs = 4 spaces by default
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set wildignore+=tags,*.o,*.py?

let g:mapleader = ' '
let g:maplocalleader = '\\'

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
" :~:.

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
" Deoplete: {{{2

call deoplete#custom#option({
            \ 'smart_case': v:true,
            \ })
let g:deoplete#enable_at_startup = 1

call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

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

augroup emmet_vim
    autocmd!
    autocmd FileType html,xml,css,scss,sass,typescriptreact EmmetInstall
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

nnoremap <A-p> :Files<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-b> :Buffers<CR>
" Grep word under cursor
nnoremap <silent> <Leader>r :Rg <C-R><C-W><CR>

command! GFiles call fzf#run(fzf#wrap({ 'source': 'GFiles' }))

augroup dsifford_fzf
    autocmd!
    autocmd  FileType fzf set laststatus=0
          \| autocmd BufLeave <buffer> set laststatus=2
augroup END

"}}}2
" NERDCommenter: {{{2

let g:NERDSpaceDelims = 1

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

let g:netrw_home=stdpath('cache')
let g:netrw_banner = 0
let g:netrw_list_hide = netrw_gitignore#Hide()

" Toggle Netrw window
noremap <silent> <expr> <C-\> &ft ==# 'netrw' ? ':Rex<CR>' : ':Explore!<CR>'

"}}}2
" Polyglot: {{{2

let g:polyglot_disabled = [
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
" SuperTab: {{{2

" <Tab> begins at top of list
let g:SuperTabDefaultCompletionType = '<C-n>'

"}}}2
" UltiSnips: {{{2

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

"}}}2
" Vim Tmux Navigator: {{{2

" Disables built-in mappings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<CR>

"}}}2
"}}}1
" Commands: {{{1

command! Reload source $MYVIMRC
command! Vimrc  vsplit ~/.dotfiles/vim/.vimrc

command! ReloadSyntax call vimrc#ReloadSyntax()
command! ZoomToggle   call vimrc#ZoomToggle()

"}}}1
" Mappings: {{{1

nnoremap Y  y$
nnoremap <silent> <Leader>l :set relativenumber!<CR>
nnoremap <silent> <Leader><Leader>l :set list!<CR>

" Make j and k move through soft line breaks
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Toggle fold
nnoremap <silent>         <CR> :pc <Bar> :exe ':silent! normal za\r'<CR>
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

    " Toggle quickfix with <Esc>
    autocmd FileType qf nnoremap <buffer><silent> <Esc> :quit<CR>

    " Flush the screen's buffer on exit
    autocmd VimLeave * :!clear

    " Don't add comment when newline added with o or O for any filetype
    autocmd FileType * set formatoptions-=o | set formatoptions+=r

    " FIXME: Pending the fix to php syntax
    " Fixes issues with PHP and other languages changing global foldmethod
    autocmd BufLeave * set foldmethod=manual
    autocmd BufEnter *.php setl foldmethod=syntax
augroup END

augroup dsifford_diff_cursorline
    autocmd!

    autocmd FilterWritePost * if &diff | set cursorline | endif
    autocmd BufEnter * if &diff | set cursorline | endif
augroup END

"}}}1

" vim: set fdm=marker:
