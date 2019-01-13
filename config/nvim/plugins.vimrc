" Initialization: {{{

let s:plug_file = stdpath('data') . '/site/autoload/plug.vim'

" Download vim-plug if it doesn't already exist
if ! filereadable(s:plug_file)
    silent exec '!curl -fLo ' . shellescape(s:plug_file) .
                \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    augroup dsifford
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    augroup END
endif

"}}}

call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-sensible'

" Essential
Plug 'justinmk/vim-sneak'
Plug 'lifepillar/vim-mucomplete'
Plug 'liuchengxu/vim-which-key'
Plug 'mattn/emmet-vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

Plug 'junegunn/fzf', { 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

" General Enhancements
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-vinegar'

" Look and feel
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Colorizer'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'machakann/vim-highlightedyank'
Plug 'vim-airline/vim-airline'

" Misc
Plug 'tpope/vim-scriptease'
Plug 'junegunn/vader.vim'

" Still not sure I want to keep
Plug 'tweekmonster/startuptime.vim'

source $MYVIMHOME/plugins.langs.vimrc

call plug#end()

" vim: set fdm=marker:
