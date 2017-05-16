" Plugins
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
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

" Keymaps
map <C-\> :NERDTreeToggle<CR>
