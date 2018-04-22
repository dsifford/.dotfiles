" vim: set fdm=marker:
scriptencoding utf8

source ~/.vim/plugins.vimrc

" Options: 
" ---------------------

set autowrite                 " Automatically save before commands like :next and :make
set clipboard=unnamedplus     " Use system clipboard
set formatoptions-=o          " Don't add comment when newline added with o or O
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

" Plugin Settings: 

" Airline: 

let g:airline#extensions#ale#enabled = 1


" Ale: 

let g:ale_fixers = {
            \    'json': [ 'prettier' ],
            \    'markdown': [ 'prettier' ],
            \    'php': [ 'phpcbf' ],
            \    'python': [ 'yapf' ],
            \    'scss': [ 'prettier' ],
            \    'sh': [ 'shfmt' ],
            \    'typescript': [ 'prettier' ],
            \}

let g:ale_linters = {
            \   'php': [ 'phpcs', 'php', 'langserver' ],
            \}

let g:ale_php_phpcs_standard = 'WordPress'
let g:ale_php_phpcbf_standard = 'WordPress'

let g:ale_sh_shfmt_options = '-i 4 -ci -bn'

let g:airline#extensions#ale#enabled = 1


" Auto Pairs: 

" Disable toggle keybinding
let g:AutoPairsShortcutToggle = ''


" Deoplete: 

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1


" Fzf: 

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-i': 'split',
    \ 'ctrl-s': 'vsplit' }

" Add support for ripgrep
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

nnoremap <C-p> :Files<CR>
nnoremap <A-p> :GFiles<CR>
nnoremap <C-b> :Buffers<CR>
" Grep word under cursor
nnoremap <silent> <Leader>r :Rg <C-R><C-W><CR>


" LanguageClient: 

let g:LanguageClient_serverCommands = {
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ 'javascript': ['typescript-language-server', '--stdio'],
            \ 'typescript': ['typescript-language-server', '--stdio'],
            \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>


" NERDTree: 

" Auto-close the NERDTree buffer when file opened
let g:NERDTreeQuitOnOpen = 1

noremap  <silent> <C-\> :NERDTreeToggle<CR>


" SuperTab: 

" <Tab> begins at top of list
let g:SuperTabDefaultCompletionType = '<C-n>'


" UltiSnips: 

" FIXME:
" let g:UltiSnipsExpandTrigger='<CR>'
" let g:UltiSnipsJumpForwardTrigger='<c-b>'
" let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='vertical'


" Vim Markdown: 

" Restrict italics to single line only
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1


" Vim Tmux Navigator: 

" Disables built-in mappings
let g:tmux_navigator_no_mappings = 1




" Commands: 

" Reload .vimrc
command! Reload source $MYVIMRC

" Open .vimrc in a vertical split
command! Vimrc vsplit ~/.dotfiles/vim/.vimrc


" Mappings: 

nnoremap Y  y$
nnoremap <silent> <Leader><Leader>l :set list!<CR>
nnoremap <silent> <Leader><Leader>n :set relativenumber!<CR>

" Make j and k move through soft line breaks
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Show highlight scope under cursor
nnoremap <silent> <Leader>s :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" " Toggle fold
nnoremap <silent> <Enter> za

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

" FIXME: Put this in autoload
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader><CR> :ZoomToggle<CR>


" Autocommands: 
" --------------------------

filetype plugin indent on

" Misc: 

augroup Misc
    autocmd!
    autocmd VimLeave * :!clear " Flush the screen's buffer on exit
    " autocmd BufEnter * if &ft !~ '^nerdtree$' | silent! lcd %:p:h | endif
    autocmd BufEnter *
        \ if &ft !~ '^nerdtree$' |
        \   silent! lcd %:p:h |
        \ endif
augroup END



