" Plugins
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'leafgarland/typescript-vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
call plug#end()

" General Settings
set t_Co=256
set number              " Show line numbers
set showcmd             " Show partial commands in last line of screen
set pastetoggle=<F2>    " Toggle paste mode with F2

" Usability
set ignorecase          " Required for proper smartcase functionality
set smartcase           " Case insensitive unless typing with caps
set shiftwidth=4        " Set hard tabs to 4 columns
set softtabstop=4       " Set soft tabs to 4 spaces
set lazyredraw          " Improves perf under some conditions

" Colors
colorscheme dracula
highlight Normal ctermbg=NONE

" Keymaps
let mapleader=" "
map <C-\> :NERDTreeToggle<CR>
