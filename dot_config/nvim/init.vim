
set number
set title
set ambiwidth=double
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
autocmd BufWritePre * :%s/\(\w\)\s\+$/\1/ge
set clipboard+=unnamed
let g:mapleader = "\<Space>"

map <Leader> ;<CR>
nnoremap <Leader>w :wq<CR>

syntax enable
filetype plugin indent on

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
Plug 'm00qek/baleia.nvim', { 'tag': 'v1.3.0' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
call plug#end()

let g:quickrun_config = {}
let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/split'  : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }
nnoremap <silent><leader>r :QuickRun<CR>

" let s:baleia = luaeval("require('baleia').setup { }")
" command! BaleiaColorize call s:baleia.once(bufnr('%'))
