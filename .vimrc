call plug#begin()
Plug 'farmergreg/vim-lastplace'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/vim-peekaboo'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lervag/vimtex'
Plug 'ycm-core/YouCompleteMe'
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-fugitive'
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
nnoremap <leader>b :Git blame<CR>

nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" switch splits with ctrl-{hjkl}
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

let g:vimtex_view_method = 'zathura'

" ocaml merlin
let g:opamshare = substitute(system('opam var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1

nmap <leader>s <Plug>SlimeParagraphSend
xmap <leader>s <Plug>SlimeRegionSend
