scriptencoding utf-8
set shell=/bin/bash

call plug#begin('~/.config/nvim/plugged')

" Project Management {{{
" localvimrc plugin needs to be at first
let g:localvimrc_ask = 1
let g:localvimrc_sandbox = 1
let g:localvimrc_persistent = 1
Plug 'embear/vim-localvimrc'

let g:rooter_change_directory_for_non_project_files = 'current'
" '.git' is needed because for git worktree, `.git` is not a directory
let g:rooter_patterns = ['.git/', '.git', '.lvimrc', '.tags', 'tags', 'pom.xml']
Plug 'airblade/vim-rooter'
"}}}

" Appearance {{{

" See ColorScheme section
" let g:airline_powerline_fonts = 1
let g:airline_symbols_ascii = 1
let g:airline#extensions#default#layout = [
            \ [ 'a', 'b', 'c' ],
            \ [ 'x', 'y', 'error', 'warning' ]
            \ ]
let g:airline#extensions#default#section_truncate_width = {
            \ 'b': 79,
            \ 'x': 60,
            \ 'y': 45,
            \ 'warning': 60,
            \ 'error': 60,
            \ }
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
" let g:airline#extensions#tagbar#enabled = 1
set noshowmode
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'lifepillar/vim-solarized8'
" Plug 'altercation/vim-colors-solarized'
" Plug 'iCyMind/NeoSolarized'

" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'jaxbot/semantic-highlight.vim'
" let g:colorcoder_enable_filetypes = ['c', 'cpp', 'python', 'rust', 'go', 'javascript', 'cuda']
" Plug 'blahgeek/neovim-colorcoder', { 'do' : ':UpdateRemotePlugins' }

" }}}

" Misc Editing Plugins {{{
Plug 'tpope/vim-repeat'

let g:multi_cursor_exit_from_insert_mode = 0
Plug 'terryma/vim-multiple-cursors'

let g:AutoPairsMultilineClose = 0
let g:AutopairsShortcutToggle = ''
let g:AutopairsShortcutFastWrap = ''
let g:AutopairsShortcutJump = ''
let g:AutopairsShortcutBackInsert = ''
let g:AutoPairsMoveCharacter = ''
Plug 'jiangmiao/auto-pairs'

Plug 'tomtom/tcomment_vim'

let g:templates_directory = '~/.config/nvim/templates/'
let g:templates_no_builtin_templates = 1
Plug 'aperezdc/vim-template'

let g:UltiSnipsExpandTrigger = '<S-TAB>'
Plug 'SirVer/ultisnips', {'on': []}
Plug 'honza/vim-snippets'

let g:closetag_filenames = '*.html,*.xml,*.js,*.jsx'
Plug 'alvan/vim-closetag'

Plug 'tpope/vim-surround'

" let g:detectindent_preferred_expandtab = 1
" let g:detectindent_preferred_indent = 4
" let g:detectindent_verbosity = 0
" Plug 'ciaranm/detectindent'

Plug 'lilydjwg/fcitx.vim'

" }}}

" Tools Integration Plugins {{{
Plug 'airblade/vim-gitgutter'

let g:ackprg = 'ag --vimgrep'
let g:ack_mappings = {
            \ '<C-s>': '<C-W><CR><C-W>K',
            \ '<C-v>': '<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t' }
cnoreabbrev ag Ack!
Plug 'mileszs/ack.vim'

Plug 'tpope/vim-fugitive'
nnoremap <C-s> :Gstatus<CR>

" let g:autoformat_retab = 0
" Plug 'Chiel92/vim-autoformat'

Plug 'sbdchd/neoformat'

" Plug 'majutsushi/tagbar'
" }}}

" LSP + Deoplete {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" source from syntax file
Plug 'Shougo/neco-syntax', { 'do': ':UpdateRemotePlugins' }
" I would manually enable it on InsertEnter
let g:deoplete#enable_at_startup = 0

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" close preview window after insertion
augroup auto_close_preview_window
    autocmd!
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    " autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
augroup END

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery'],
    \ 'c': ['cquery'],
    \ 'python': ['pyls'],
    \ 'rust': ['rls'],
    \ 'java': [expand('<sfile>:p:h') . '/lsp/jdtls.wrapper.sh']
    \ }
" \ 'java': ['jdtls', '-Dlog.level=ALL', '-Djdt.ls.debug=1'],
" TODO: highlights from gitgutter are used here
let g:LanguageClient_diagnosticsDisplay =
            \    {
            \        1: {
            \            "name": "Error",
            \            "texthl": "Error",
            \            "signText": "--",
            \            "signTexthl": "GitGutterDelete",
            \        },
            \        2: {
            \            "name": "Warning",
            \            "texthl": "Ignore",
            \            "signText": "--",
            \            "signTexthl": "GitGutterChange",
            \        },
            \        3: {
            \            "name": "Information",
            \            "texthl": "Ignore",
            \            "signText": "--",
            \            "signTexthl": "SignColumn",
            \        },
            \        4: {
            \            "name": "Hint",
            \            "texthl": "Ignore",
            \            "signText": "--",
            \            "signTexthl": "SignColumn",
            \        },
            \    }
let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = expand('<sfile>:p:h') . '/lsp/settings.json'
let g:LanguageClient_fzfOptions = ''

nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> gx :call LanguageClient_textDocument_codeAction()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
set formatexpr=LanguageClient#textDocument_rangeFormatting()

" }}}

" {{{ Filetypes support

" ftplugin/fish is very slow (would execute fish)
let g:polyglot_disabled = ['javascript', 'jsx']
Plug 'sheerun/vim-polyglot'

let g:jsx_improve_motion_disable = 1
Plug 'chemzqm/vim-jsx-improve'

Plug 'davidoc/taskpaper.vim'

" }}}

" TODO: i3wm & vim panes

call plug#end()

augroup plug_lazyload_insert
    autocmd!
    autocmd InsertEnter * call plug#load('ultisnips')
                \| call deoplete#enable()
                \| autocmd! plug_lazyload_insert
augroup END


" Sensible Configuration {{{
set clipboard+=unnamedplus
set smartindent
set smartcase
set nowrap
set number
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set tabstop=4
set shiftwidth=4
set expandtab
set sidescroll=1
set scrolloff=3
set visualbell
set ttimeoutlen=10
set fileencodings=ucs-bom,utf-8,gb2312,gbk,gb18030,latin1
set wildignore+=*.so,*.swp,*.zip,*.o,*.pyc
set foldmethod=marker
set display=truncate
set mouse=
set cursorline
set inccommand=nosplit
" set cinoptions=N-s,j1,(0,ws,Ws
set cinoptions+=g0,j1,(0,ws,W2s,ks,m1
set hidden
" }}}

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" FZF {{{

" Load fzf plugin (installed by fzf package)
source /usr/share/vim/vimfiles/plugin/fzf.vim

function s:FZFSinkWrapper(cmd, target)
    execute a:cmd fnameescape(a:target[0])
endfunction

function s:FZFFiles()
    let l:source = 'git ls-files -oc --exclude-standard'
    " fallback to ag if not a git repo
    if fugitive#head() ==# ''
        let l:source = 'ag -g ""'
    endif
    let g:fzf_action = {
                \ 'ctrl-s': 'split',
                \ 'ctrl-v': 'vsplit' }
    call fzf#run(fzf#wrap({ 'source': l:source }))
endfunction

function s:FZFTags()
    let l:tagfiles = tagfiles()
    if empty(l:tagfiles)
        echo 'No tagfile found'
        return
    endif
    let g:fzf_action = {
                \ 'ctrl-s': function('s:FZFSinkWrapper', ['stjump']),
                \ 'ctrl-v': function('s:FZFSinkWrapper', ['vertical stjump']),
                \ 'enter': function('s:FZFSinkWrapper', ['tjump']) }
    let l:source = 'cut -f 1 ' . join(l:tagfiles) . ' | grep -v "^!" | uniq'
    call fzf#run(fzf#wrap({ 'source': l:source }))
endfunction

function s:FZFTagsCurrentFile_goto(line)
    execute split(a:line, '\t')[1]
endfunction

function s:FZFTagsCurrentFile()
    call fzf#run(fzf#wrap({
                \ 'source': 'ctags -f - --excmd=number "' . expand('%:p') . '" | cut -f 1,3 | grep -v "^!"',
                \ 'sink': function('s:FZFTagsCurrentFile_goto'),
                \ 'options': '--nth 1 --with-nth 1',
                \ }))
endfunction

command! FZFFiles call s:FZFFiles()
nnoremap <silent> <C-p> :FZFFiles<CR>

command! FZFTags call s:FZFTags()
nnoremap <silent> <C-r> :FZFTags<CR>

command! FZFTagsCurrentFile call s:FZFTagsCurrentFile()
nnoremap <silent> <C-g> :FZFTagsCurrentFile<CR>
" }}}

" Colorscheme {{{

set signcolumn=yes
set termguicolors
let g:airline_theme = 'solarized'

function s:update_colorscheme()
    if $SUNWAIT_STATUS ==? 'DAY'
        let g:airline_solarized_bg = 'light'
        set background=light
    else
        let g:airline_solarized_bg = 'dark'
        set background=dark
    endif
    if exists(':AirlineRefresh')
        AirlineRefresh
    endif
    colorscheme solarized8
endfunction

command! UpdateColorscheme call s:update_colorscheme()
call s:update_colorscheme()

" }}}

nnoremap <ESC><ESC> :nohlsearch<CR>

function s:update_header_modified_time()
    " undojoin | normal! ix
    " undojoin | normal! x
    let l:save_view = winsaveview()
    let l:now = strftime('%Y-%m-%d')
    execute '1,10s/Last Modified.* \zs\d\+-\d\+-\d\+\ze$/' . l:now . '/i'
    call winrestview(l:save_view)
endfunction

augroup vimrc_augroup
    autocmd!
    " Remember last cursor position
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
    autocmd BufWritePre * silent! call s:update_header_modified_time()
    " React to window resize
    autocmd VimResized * wincmd =
    autocmd VimResized * redraw!
    autocmd BufWritePre *.go :Neoformat
augroup END
