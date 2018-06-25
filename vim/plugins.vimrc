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

"}}}

call plug#begin('~/.vim/_plugins')

Plug 'tpope/vim-sensible'

" Essential
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'w0rp/ale'

if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
        Plug 'roxma/LanguageServer-php-neovim',  { 'do': 'composer install && composer run-script parse-stubs' }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug 'Shougo/neoinclude.vim'
endif

" General Enhancements
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-easy-align'

" Look and feel
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Colorizer'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'machakann/vim-highlightedyank'
Plug 'vim-airline/vim-airline'

" Language / Syntax
Plug 'davidhalter/jedi-vim'
Plug 'justinmk/vim-syntax-extra'
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'
Plug 'HerringtonDarkholme/yats.vim'

" Misc
Plug 'tpope/vim-scriptease'

" Still not sure I want to keep
Plug 'Shougo/echodoc.vim'

call plug#end()

" vim: set fdm=marker:
