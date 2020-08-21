" ~/.config/nvim/init.vim

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

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

call plug#end()

" yggdroot/indentline
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 239

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

