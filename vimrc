" Vundle Requirements
set nocompatible 
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Insert all Vundle Plugins below

Plugin 'molokai'		 " Molokai color scheme
Plugin 'godlygeek/tabular'	 " Markdown tab formatting
Plugin 'plasticboy/vim-markdown' " Markdown
Plugin 'scrooloose/nerdtree'	 " NERDtree

call vundle#end()
filetype plugin indent on

" Keymaps
noremap <C-\> :NERDTreeToggle<CR>

" General Settings
set t_Co=256
set number			" Show line numbers
set wildmenu			" Better command menu
set showcmd			" Show partial commands in last line of screen

" Usability
set ignorecase			" Required for proper smartcase functionality
set smartcase			" Case insensitive unless typing with caps
set autoindent			" Autoindent for language-specific settings
set shiftwidth=4
set softtabstop=4

" Sensible Vim Options
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu
set lazyredraw

if !&scrolloff
    set scrolloff=1
endif
if !&sidescrolloff
    set sidescrolloff=5
endif

set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
endif

if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread

if &history < 1000
    set history=1000
endif
if &tabpagemax < 50
    set tabpagemax=50
endif
if !empty(&viminfo)
    set viminfo^=!
endif

set sessionoptions-=options
inoremap <C-U> <C-G>u<C-U>

" Colors
syntax enable
colorscheme molokai
