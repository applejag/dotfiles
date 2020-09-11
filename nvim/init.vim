" ~/.config/nvim/init.vim

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }

" Syntax highlighting
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" f#
Plug 'ionide/Ionide-vim', {
      \ 'do':  'make fsautocomplete',
      \}

Plug 'Shougo/echodoc.vim'

" crystal-lang
Plug 'vim-crystal/vim-crystal'
Plug 'vim-syntastic/syntastic'

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
Plug 'ycm-core/YouCompleteMe'
Plug 'ervandew/supertab'

" Typescript
Plug 'jason0x43/vim-js-indent'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/deoplete.nvim' " For async completion
Plug 'Shougo/denite.nvim' " For Denite features

call plug#end()

" yggdroot/indentline
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 239

" Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1

" Shougo/echodoc.vim
set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
  \ 'fsharp': g:fsharp#languageserver_command
  \ }

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType fs,fsi,fsx call SetLSPShortcuts()
augroup END

nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
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

" Escape '-- TERMINAL --' mode with ESC
tnoremap <Esc> <C-\><C-n>

