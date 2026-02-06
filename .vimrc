call plug#begin()
Plug 'farmergreg/vim-lastplace'
Plug 'junegunn/vim-peekaboo'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lervag/vimtex'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> <leader>co  :<C-u>CocList outline<CR>
nnoremap <silent> <leader>d  :<C-u>CocList diagnostics<cr>

nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-l>"

let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []

let g:vimtex_view_method = 'zathura'
let g:vimtex_view_forward_search_on_start = 0

let g:NERDTreeFileLines = 1


autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif


highlight CocErrorVirtualText guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight CocWarningVirtualText guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight CocInfoVirtualText guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight CocHintVirtualText guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

highlight DiagnosticVirtualTextError guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight DiagnosticVirtualTextWarn guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight DiagnosticVirtualTextInfo guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight DiagnosticVirtualTextHint guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

augroup TransparentBackground
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight VertSplit ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE
augroup END

colorscheme torte
