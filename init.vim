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
let g:rooter_patterns = ['.git/', '.git', '.lvimrc', '.tags', 'tags']
Plug 'airblade/vim-rooter'
"}}}

" Appearance {{{
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'
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

" Filetype supports
Plug 'sheerun/vim-polyglot'
" ftplugin/fish is very slow (would execute fish)
" let g:polyglot_disabled = ['fish']

Plug 'tpope/vim-surround'

" let g:detectindent_preferred_expandtab = 1
" let g:detectindent_preferred_indent = 4
" let g:detectindent_verbosity = 0
" Plug 'ciaranm/detectindent'
" }}}

" ALE Linters {{{
let g:ale_linters = {
            \    'c': ['gcc'],
            \    'cpp': ['g++'],
            \    'python': ['flake8'],
            \    'go': ['go build', 'gofmt']
            \}
let g:ale_set_highlights = 0
let g:ale_sign_column_always = 1
set signcolumn=yes
let g:ale_echo_delay = 200
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_rust_cargo_use_check = 1
let g:airline#extensions#ale#enabled = 1
Plug 'w0rp/ale'
" }}}

" Tools Integration Plugins {{{
Plug 'airblade/vim-gitgutter'

let g:ackprg = 'ag --vimgrep'
cnoreabbrev ag Ack!
Plug 'mileszs/ack.vim'

Plug 'tpope/vim-fugitive'
nnoremap <C-s> :Gstatus<CR>

let g:autoformat_retab = 0
Plug 'Chiel92/vim-autoformat'

Plug 'davidoc/taskpaper.vim'

" Plug 'majutsushi/tagbar'
" }}}

" YouCompleteMe {{{
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_echo_current_diagnostic = 0
let g:ycm_collect_identifiers_from_tags_files = 1

" Common C/CXX Flags, initial value same as ale_c_gcc_options
let g:common_c_flags = ['-std=c11']
let g:common_cxx_flags = ['-std=c++14']
let g:ycm_extra_conf_vim_data = ['g:common_c_flags', 'g:common_cxx_flags']
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/extra/ycm_extra_conf.py'

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<Up>', '<C-k>']
let g:ycm_rust_src_path = '/usr/src/rust/src/'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all', 'on': []}
nmap gd :YcmCompleter GoTo<CR>
cnoreabbrev fix YcmCompleter FixIt
" }}}

" TODO: i3wm & vim panes
" TODO: tasks format

call plug#end()

augroup plug_lazyload_insert
    autocmd!
    autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe')
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
set termguicolors
set background=dark
colorscheme solarized8
" set ALESign background like LineNr
hi Error guibg=#073642 ctermbg=236
hi Todo guibg=#073642 ctermbg=236
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
    autocmd BufWritePre *.go :Autoformat
augroup END
