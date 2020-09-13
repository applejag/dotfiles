" ~/.config/nvim/init.vim

source ~/.config/nvim/base.vim

call plug#begin('~/.vim/plugged')

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

" Utility
Plug 'ycm-core/YouCompleteMe'
Plug 'ervandew/supertab'

" Typescript
Plug 'jason0x43/vim-js-indent'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/deoplete.nvim' " For async completion
Plug 'Shougo/denite.nvim' " For Denite features

call plug#end()

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

