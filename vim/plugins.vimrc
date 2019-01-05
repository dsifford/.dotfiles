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
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'tomtom/tcomment_vim'
Plug 'liuchengxu/vim-which-key'
Plug 'w0rp/ale'
Plug 'lifepillar/vim-mucomplete'

Plug 'junegunn/fzf', { 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

" General Enhancements
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-vinegar'

" Look and feel
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Colorizer'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'machakann/vim-highlightedyank'
Plug 'vim-airline/vim-airline'

" Language / Syntax
Plug 'davidhalter/jedi-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'justinmk/vim-syntax-extra'
Plug 'lervag/vimtex'
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot', { 'do': './build' }

" Misc
Plug 'tpope/vim-scriptease'
Plug 'junegunn/vader.vim'

" Still not sure I want to keep
Plug 'tweekmonster/startuptime.vim'

call plug#end()

" vim: set fdm=marker:
