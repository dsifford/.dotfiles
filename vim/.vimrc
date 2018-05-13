scriptencoding utf8
filetype plugin indent on

source ~/.vim/plugins.vimrc

" Options: {{{1
colorscheme dracula

set autowrite                 " Automatically save before commands like :next and :make
set clipboard=unnamedplus     " Use system clipboard
set history=200               " Truncate history at 200 lines
set ignorecase                " Required for proper smartcase functionality
set lazyredraw                " Improves perf under some conditions
set listchars=tab:▸\ ,eol:¬   " Symbols for whitespace when 'set list' enabled
set nowrap                    " Disable line wrapping
set number                    " Show line numbers
set pastetoggle=<F2>          " Toggle paste mode with F2
set shiftround                " Round indents to nearest indent size when using < or >
set smartcase                 " Case insensitive unless typing with caps
set smarttab                  " sw at the start of the line, sts everywhere else
set splitbelow                " Open horizontal splits below current buffer
set splitright                " Open vertical splits to the right of current buffer
set termguicolors             " Force GUI colors in terminals
set virtualedit=block         " Allow cursor to be placed in virtual positions when in visual block mode
set winaltkeys=no             " Allows all ALT combinations to be mapped

" Tabs = 4 spaces by default
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set wildignore+=tags,*.o,*.py?

let g:mapleader = ' '
let g:netrw_home=$XDG_CACHE_HOME . '/vim'
let g:sh_fold_enabled=1

if has('nvim')
    set inccommand=split
endif
"}}}1
" Plugin Settings: {{{1
" Airline: {{{2

let g:airline#extensions#ale#enabled = 1

"}}}2
" ALE: {{{2

let g:ale_fixers = {
            \    'json': [ 'prettier' ],
            \    'markdown': [ 'prettier' ],
            \    'php': [ 'phpcbf' ],
            \    'python': [ 'yapf' ],
            \    'scss': [ 'prettier', 'stylelint' ],
            \    'sh': [ 'shfmt' ],
            \    'typescript': [ 'prettier', 'tslint' ],
            \    'typescriptreact': [ 'prettier', 'tslint' ],
            \}

let g:ale_linters = {
            \   'php': [ 'phpcs', 'php', 'langserver' ],
            \   'typescript': [ 'tslint', 'tsserver' ],
            \   'typescriptreact': [ 'tslint', 'tsserver' ],
            \}

let g:ale_linter_aliases = {'typescriptreact': 'typescript'}

let g:ale_php_phpcs_standard = 'WordPress'
let g:ale_php_phpcbf_standard = 'WordPress'

let g:ale_sh_shfmt_options = '-i 4 -ci -bn'

let g:airline#extensions#ale#enabled = 1

nmap          <Leader>f <Plug>(ale_fix)
nmap <silent> <C-k>     <Plug>(ale_previous_wrap)
nmap <silent> <C-j>     <Plug>(ale_next_wrap)

"}}}2
" Auto Pairs: {{{2

" Disable toggle keybinding
let g:AutoPairsShortcutToggle = ''

"}}}2
" Colorizer: {{{2

let g:colorizer_auto_filetype='css,scss'
let g:colorizer_colornames = 0

"}}}2
" Commentary: {{{2

noremap  <silent> <C-_> :Commentary<CR>
inoremap <silent> <C-_> <Esc>:Commentary<CR>i

"}}}2
" Deoplete: {{{2

call deoplete#custom#option({
            \ 'smart_case': v:true,
            \ 'complete_method': 'omnifunc'
            \ })
let g:deoplete#enable_at_startup = 1

call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])

"}}}2
" EasyAlign: {{{2

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(LiveEasyAlign)

"}}}2
" Fzf: {{{2

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-i': 'split',
            \ 'ctrl-s': 'vsplit' }

function! s:CompleteRg(arg_lead, line, pos)
    let l:args = join(split(a:line)[1:])
    return systemlist('get_completions rg ' . l:args)
endfunction

" Add support for ripgrep
command! -bang -complete=customlist,s:CompleteRg -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.<q-args>, 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

nnoremap <A-p> :Files<CR>
nnoremap <C-p> :GFiles -co --exclude-standard<CR>
nnoremap <C-b> :Buffers<CR>
" Grep word under cursor
nnoremap <silent> <Leader>r :Rg <C-R><C-W><CR>

"}}}2
" LanguageClient: {{{2

let g:LanguageClient_serverCommands = {
            \ 'javascript': ['typescript-language-server', '--stdio'],
            \ 'python': ['pyls'],
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ 'typescript': ['typescript-language-server', '--stdio'],
            \ 'typescriptreact': ['typescript-language-server', '--stdio'],
            \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

"}}}2
" NERDTree: {{{2

" Auto-close the NERDTree buffer when file opened
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeBookmarksFile = $XDG_CACHE_HOME . '/nerdtree/bookmarks'
let g:NERDTreeMinimalUI = 1
let g:NERDTreeHijackNetrw=1

let g:NERDTreeIgnore = [
            \ 'node_modules$[[dir]]'
            \ ]

noremap  <silent> <C-\> :NERDTreeToggle<CR>

"}}}2
" Polyglot: {{{2

let g:polyglot_disabled = [
            \ 'php',
            \ 'scss',
            \ 'typescript',
            \ 'yaml',
            \]

" Markdown: {{{3
" Restrict italics to single line only
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
"}}}3

"}}}2
" Scriptease: {{{2

" Show syntax groups under cursor
nmap <silent> <Leader>s <Plug>ScripteaseSynnames

"}}}2
" SuperTab: {{{2

" <Tab> begins at top of list
let g:SuperTabDefaultCompletionType = '<C-n>'

"}}}2
" UltiSnips: {{{2

" FIXME:
" let g:UltiSnipsExpandTrigger='<CR>'
" let g:UltiSnipsJumpForwardTrigger='<c-b>'
" let g:UltiSnipsJumpBackwardTrigger='<c-z>'
" let g:UltiSnipsEditSplit='vertical'

" let g:UltiSnipsJumpForwardTrigger='<tab>'
" let g:UltiSnipsJumpBackwardTrigger='<S-tab>'
" let g:UltiSnipsExpandTrigger='<nop>'
" let g:ulti_expand_or_jump_res = 0
" function! <SID>ExpandSnippetOrReturn()
"   let l:snippet = UltiSnips#ExpandSnippetOrJump()
"   if g:ulti_expand_or_jump_res > 0
"     return l:snippet
"   else
"     return "\<CR>"
"   endif
" endfunction
" inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

"}}}2
" Vim Tmux Navigator: {{{2

" Disables built-in mappings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<CR>

"}}}2
"}}}1
" Commands: {{{1

command! Reload source $MYVIMRC
command! ReloadSyntax call vimrc#ReloadSyntax()
command! Vimrc vsplit ~/.dotfiles/vim/.vimrc
command! ZoomToggle call vimrc#ZoomToggle()

"}}}1
" Mappings: {{{1

nnoremap Y  y$
nnoremap <silent> <Leader>l :set relativenumber!<CR>
nnoremap <silent> <Leader><Leader>l :set list!<CR>

" Make j and k move through soft line breaks
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Toggle fold
nnoremap <silent> <Enter> za
" Toggle window fullscreen
nnoremap <silent> <Leader><CR> :ZoomToggle<CR>

" Search project with ripgrep
nnoremap <Leader>/ :Rg<Space>

"}}}1
" Autocommands: {{{1

augroup dsifford_misc
    autocmd!

    " Toggle quickfix with <Esc>
    autocmd FileType qf nnoremap <buffer><silent> <Esc> :quit<CR>

    " Flush the screen's buffer on exit
    autocmd VimLeave * :!clear

    " Set cwd to file directory for cd_filetypes
    if ! exists('s:initial_wd')
        let s:initial_wd = getcwd()
    endif
    let s:cd_filetypes = [
                \ 'typescript',
                \ 'typescriptreact',
                \ ]
    autocmd BufRead,BufNewFile * if index(s:cd_filetypes, &ft) == -1      |
                \          silent exec 'lcd ' . fnameescape(s:initial_wd) |
                \      else                                               |
                \          lcd %:p:h                                      |
                \      endif

    " Don't add comment when newline added with o or O for any filetype
    autocmd FileType * set formatoptions-=o | set formatoptions+=r
augroup END

"}}}1

" vim: set fdm=marker:
