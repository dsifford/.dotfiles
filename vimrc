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

call vundle#end()
filetype plugin indent on

" General Settings
set number			" Show line numbers
set wildmenu			" Better command menu
set showcmd			" Show partial commands in last line of screen

" Usability
set ignorecase			" Required for proper smartcase functionality
set smartcase			" Case insensitive unless typing with caps
set autoindent			" Autoindent for language-specific settings
set shiftwidth=4
set softtabstop=4

" Colors
syntax enable
colorscheme molokai
