
call plug#begin('~/.vim/plugged')

if has('nvim')
    Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" General Enhancements
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

" Look and feel
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'machakann/vim-highlightedyank'

" Language / Syntax
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'markdown' ] }
Plug 'junegunn/vader.vim', { 'for': 'vim' }
Plug 'justinmk/vim-syntax-extra', { 'for': 'c' }

" Still not sure I want to keep
Plug 'jiangmiao/auto-pairs'

call plug#end()

