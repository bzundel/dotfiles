call plug#begin()
Plug 'farmergreg/vim-lastplace'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/vim-peekaboo'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

set nocompatible
set backspace=indent,eol,start
syntax on
set number relativenumber
set scrolloff=10
set wrap
set hlsearch
set incsearch
set showcmd
set showmode
set showmatch
set background=dark

let mapleader=","

map <space> /
nnoremap <leader>n :noh<CR>

nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
