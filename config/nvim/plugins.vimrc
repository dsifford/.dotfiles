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

"
" Essential:
"
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'liuchengxu/vim-which-key'
Plug 'kana/vim-textobj-user'

Plug 'junegunn/fzf', { 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

"
" General Enhancements:
"
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'andymass/vim-matchup'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-vinegar'
" FIXME: I'm pretty sure I'm not using ncm2 anymore. Check to see why and if I should remove this
Plug 'ncm2/float-preview.nvim'

"
" Look And Feel:
"
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'chrisbra/Colorizer'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'

"
" Misc:
"
Plug 'tweekmonster/startuptime.vim'
Plug 'tpope/vim-scriptease'
Plug 'Konfekt/FastFold'
Plug 'tpope/vim-fugitive'

runtime plugins.langs.vimrc

call plug#end()
