call plug#begin()
Plug 'farmergreg/vim-lastplace'
Plug 'junegunn/vim-peekaboo'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lervag/vimtex'
Plug 'ycm-core/YouCompleteMe'
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-fugitive'
call plug#end()

syntax on

set nocompatible
set backspace=indent,eol,start
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
nnoremap <leader>b :Git blame<CR>

let g:vimtex_view_method = 'zathura'
let g:vimtex_view_forward_search_on_start = 0
