" vim: set fdm=marker:
scriptencoding utf8

source ~/.vim/plugins.vimrc

" Options: {{{1
" ---------------------

set autowrite                 " Automatically save before commands like :next and :make
set clipboard=unnamedplus     " Use system clipboard
set history=200               " Truncate history at 200 lines
set ignorecase                " Required for proper smartcase functionality
set lazyredraw                " Improves perf under some conditions
set listchars=tab:▸\ ,eol:¬   " Symbols for whitespace when 'set list' enabled
set nowrap                    " Disable line wrapping
set number                    " Show line numbers
set pastetoggle=<F2>          " Toggle paste mode with F2
set shiftround                " Round indents to nearest indent size when using < or >
set smartcase                 " Case insensitive unless typing with caps
set smarttab                  " sw at the start of the line, sts everywhere else
set splitbelow                " Open horizontal splits below current buffer
set splitright                " Open vertical splits to the right of current buffer
set termguicolors             " Force GUI colors in terminals
set ts=4 sts=4 sw=4 expandtab " Tabs = 4 spaces by default
set virtualedit=block         " Allow cursor to be placed in virtual positions when in visual block mode
set winaltkeys=no             " Allows all ALT combinations to be mapped

set wildignore+=tags,*.o,*.py?

colorscheme dracula

let g:mapleader = ' '

if has('nvim')
    set inccommand=split
endif

" Plugin Settings: {{{1

" Ale: {{{2

let g:ale_fixers = {
            \    'json': [ 'prettier' ],
            \    'markdown': [ 'prettier' ],
            \    'php': [ 'phpcbf' ],
            \    'python': [ 'yapf' ],
            \    'sh': [ 'shfmt' ],
            \}

let g:ale_linters = {
            \   'php': [ 'phpcs', 'php', 'langserver' ],
            \}

let g:ale_php_phpcs_standard = 'WordPress'
let g:ale_php_phpcbf_standard = 'WordPress'

let g:ale_sh_shfmt_options = '-i 4 -ci -bn'

"}}}2
" Auto Pairs: {{{2

" Disable toggle keybinding
let g:AutoPairsShortcutToggle = ''

"}}}2
" Deoplete: {{{

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

"}}}2
" Fzf: {{{2

" Add support for ripgrep
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

nnoremap <C-p> :Files<CR>
nnoremap <A-p> :GFiles<CR>
" Grep word under cursor
nnoremap <silent> <Leader>r :Rg <C-R><C-W><CR>

"}}}2
" LanguageClient: {{{2

let g:LanguageClient_serverCommands = {
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ 'javascript': ['typescript-language-server', '--stdio'],
            \ 'typescript': ['typescript-language-server', '--stdio'],
            \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

"}}}2
" NERDTree: {{{2

" Auto-close the NERDTree buffer when file opened
let g:NERDTreeQuitOnOpen = 1

"}}}2
" SuperTab: {{{2

" <Tab> begins at top of list
let g:SuperTabDefaultCompletionType = '<C-n>'

"}}}2
" UltiSnips: {{{2

" FIXME:
" let g:UltiSnipsExpandTrigger='<CR>'
" let g:UltiSnipsJumpForwardTrigger='<c-b>'
" let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='vertical'

"}}}2
" Vim Markdown: {{{2

" Restrict italics to single line only
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

"}}}2
" Vim Tmux Navigator: {{{2

" Disables built-in mappings
let g:tmux_navigator_no_mappings = 1

"}}}2

"}}}1
" Commands: {{{1

" Reload .vimrc
command! Reload source $MYVIMRC

" Open .vimrc in a vertical split
command! Vimrc vsplit ~/.dotfiles/vim/.vimrc

"}}}1
" Mappings: {{{1

nnoremap Y  y$
nnoremap <silent> <Leader><Leader>l :set list!<CR>
nnoremap <silent> <Leader><Leader>n :set relativenumber!<CR>

" Show highlight scope under cursor
nnoremap <silent> <Leader><Leader>s :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" " Toggle fold
nnoremap <silent> <Enter> za

noremap  <silent> <C-\> :NERDTreeToggle<CR>
noremap  <silent> <C-_> :Commentary<CR>
inoremap <silent> <C-_> <Esc>:Commentary<CR>i

nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<CR>

nmap          <Leader>f <Plug>(ale_fix)
nmap <silent> <C-k>     <Plug>(ale_previous_wrap)
nmap <silent> <C-j>     <Plug>(ale_next_wrap)

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(LiveEasyAlign)

"}}}1
" Autocommands: {{{1
" --------------------------

filetype plugin indent on

" Misc: {{{2

augroup Misc
    autocmd!
    autocmd VimLeave * :!clear " Flush the screen's buffer on exit
augroup END

"}}}2

