filetype plugin indent on

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

" Look and feel
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'

" Language / Syntax
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }

" Still not sure I want to keep
Plug 'bling/vim-bufferline'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'kshenoy/vim-signature'
call plug#end()

" General Settings
set t_Co=256
set nowrap                          " Disable line wrapping
set number                          " Show line numbers
set showcmd                         " Show partial commands in last line of screen
set pastetoggle=<F2>                " Toggle paste mode with F2
set tabstop=4                       " when indenting with '>', use 4 spaces width
set shiftwidth=4                    " Set hard tabs to 4 columns
set softtabstop=4                   " Set soft tabs to 4 spaces
set expandtab                       " Convert tabs to spaces
set clipboard=unnamedplus           " Use system clipboard

" Usability
set ignorecase                      " Required for proper smartcase functionality
set smartcase                       " Case insensitive unless typing with caps
set lazyredraw                      " Improves perf under some conditions

" Colors
colorscheme dracula
highlight Normal ctermbg=NONE

" Keymaps
let mapleader=" "                   " Use space as <leader>
map <C-\> :NERDTreeToggle<CR>
map <C-_> gcc

" Autocommands
autocmd VimLeave * :!clear          " Flush the screen's buffer on exit

" Plugin Settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:SuperTabCrMapping = 1

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(LiveEasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

map <A-l> :insert hello<Esc>

" ALE Fixers
map <leader><C-i> <Plug>(ale_fix)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_sh_shfmt_options = '-i 4 -ci -bn'
let g:ale_fixers = {
\    'sh': [ 'shfmt'],
\    'markdown': [ 'prettier' ],
\}

" Tmux stuff
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>

