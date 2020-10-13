" ~/.config/nvim/base.vim

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

" crystal-lang
Plug 'vim-crystal/vim-crystal'
Plug 'vim-syntastic/syntastic'

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }

" Utility
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'yggdroot/indentline'

if !empty(glob('~/.config/nvim/local.vim'))
  source $HOME/.config/nvim/local.vim
endif

call plug#end()

" yggdroot/indentline
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 239

" Syntastic
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Misc settings
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set number
set relativenumber
set cursorline
set colorcolumn=80
set showtabline=2
colorscheme dracula
let mapleader = ','
let g:mapleader = ','
hi Normal ctermbg=None
hi Comment cterm=Italic

" Escape '-- TERMINAL --' mode with ESC
tnoremap <Esc> <C-\><C-n>

