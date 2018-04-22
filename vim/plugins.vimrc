" Initialization: {{{

" Download vim-plug if it doesn't already exist
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup plugins_vimrc
        autocmd!
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    augroup END
endif

"Automatically install missing plugins on startup
augroup plugins_vimrc
    autocmd VimEnter *
                \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \|   PlugInstall --sync | q
                \| endif
augroup END

"}}}

call plug#begin('~/.vim/_plugins')

Plug 'tpope/vim-sensible'

" Essential
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'w0rp/ale'

if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" General Enhancements
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'

" Look and feel
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'machakann/vim-highlightedyank'

" Language / Syntax
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'markdown' ] }
Plug 'plasticboy/vim-markdown'
Plug 'justinmk/vim-syntax-extra'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'PotatoesMaster/i3-vim-syntax'

" Still not sure I want to keep
Plug 'junegunn/goyo.vim'
Plug 'terryma/vim-multiple-cursors'

call plug#end()

" vim: set fdm=marker:
