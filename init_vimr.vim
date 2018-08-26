let $SHELL = '/usr/local/bin/fish'
" tell fish shell that I'm in a vim terminal
let $VIM_TERMINAL = 1
set shell=$SHELL

call plug#begin('~/.config/nvim/plugged')
Plug 'lifepillar/vim-solarized8'
call plug#end()

set noruler
set clipboard+=unnamedplus
set laststatus=1
set inccommand=nosplit

set termguicolors
set background=light
colorscheme solarized8

nnoremap <ESC><ESC> :nohlsearch<CR>
tnoremap <C-a>v <C-\><C-n>:vsp term://fish<CR>
tnoremap <C-a>s <C-\><C-n>:new term://fish<CR>
tnoremap <C-a>t <C-\><C-n>:tabe term://fish<CR>
tnoremap <C-a>: <C-\><C-n>:
tnoremap <C-a>/ <C-\><C-n>/
tnoremap <C-a>? <C-\><C-n>?
for c in ['h', 'j', 'k', 'l', 'H', 'J', 'K', 'L', '+', '-', '<', '=', '>', 'T', 'w', '<Down>', '<Up>', '<Left>', '<Right>']
    " execute wincmd and then start insert
    execute 'tnoremap <C-a>' . c . ' <C-\><C-n><C-w>' . c . 'i'
endfor
for n in range(10)
    " tnoremap <C-a>0 <C-\><C-n>0gti
    " tnoremap <D-0> <C-\><C-n>0gti
    execute 'tnoremap <C-a>' . n . ' <C-\><C-n>' . n . 'gti'
    execute 'tnoremap <D-' . n . '> <C-\><C-n>' . n . 'gti'
endfor
" tnoremap <C-a> <C-\><C-n><C-w>

autocmd VimEnter * nested terminal
" autocmd BufWinEnter,WinEnter,BufEnter * startinsert
autocmd TermOpen * startinsert
" https://github.com/neovim/neovim/issues/8905
autocmd TermClose * call feedkeys("\<C-\>\<C-n>:q\<CR>")
" this is interesting.. it would also execute after TermClose, works great
autocmd CmdlineLeave : startinsert

function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' [' . tab . '] '
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction
set tabline=%!Tabline()
