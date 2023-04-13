" ~/.config/nvim/base.vim

set nocompatible              " be iMproved, required
"filetype off                  " required

call plug#begin()

" Coc.vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }

" Utility
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'yggdroot/indentline'
"Plug 'ervandew/supertab'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mickael-menu/zk-nvim'

" Spelling
Plug 'kamykn/spelunker.vim'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'earthly/earthly.vim', { 'branch': 'main' }

call plug#end()

" ZK options
lua << EOF
require("zk").setup({
  picker = "fzf",
  lsp = {
    auto_attach = {
      enabled = false,
    },
  },
})
EOF

" Tab from top instead of from bottom
let g:SuperTabDefaultCompletionType = "<c-n>"

let mapleader = ','
let g:mapleader = ','
let g:vim_markdown_conceal=0

"" CoC
let g:coc_global_extensions = ['coc-json', 'coc-yaml', 'coc-go']

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

"" CoC end

" ALE
let g:ale_disable_lsp = 1
let g:ale_writegood_use_global = 1
let g:ale_writegood_options = '--no-passive'
let g:ale_alex_use_global = 1

" Always show the signcolumn, even if there are no errors/messages
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Allow comments in JSON files
autocmd FileType json syntax match Comment +\/\/.\+$+

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

" Custom filetypes
autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
autocmd BufRead,BufNewFile */playbooks/*.yaml set filetype=yaml.ansible
autocmd BufRead,BufNewFile */roles/*/tasks/*.yml set filetype=yaml.ansible
autocmd BufRead,BufNewFile */roles/*/tasks/*.yaml set filetype=yaml.ansible
autocmd BufRead,BufNewFile */.kube/config set filetype=yaml nowrap
autocmd BufRead,BufNewFile kubeconfig* set filetype=yaml nowrap
autocmd BufRead,BufNewFile /tmp/kubeconfigs/* set filetype=yaml nowrap
autocmd BufRead,BufNewFile *.yaml.off set filetype=yaml
autocmd BufRead,BufNewFile *.yml.off set filetype=yaml
autocmd BufRead,BufNewFile /dev/shm/gopass-edit*/secret set filetype=yaml nowrap
autocmd BufRead,BufNewFile */ansible/hosts set filetype=dosini
autocmd BufRead,BufNewFile */ri-secrets/values-secret.yaml set nowrap
autocmd BufRead,BufNewFile */ri-clustersecret/values-secret.yaml set nowrap
autocmd BufRead,BufNewFile JenkinsFile set filetype=Jenkinsfile
autocmd BufRead,BufNewFile */templates/NOTES.txt set filetype=gotexttmpl
autocmd BufRead,BufNewFile PROJECT set filetype=yaml

" Misc settings
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set number
set relativenumber
set cursorline
set colorcolumn=80
set showtabline=2
set conceallevel=0
colorscheme dracula
hi Normal ctermbg=None
hi Comment cterm=Italic ctermfg=darkcyan

" Color settings
" :h coc-highlights
hi CocFadeOut ctermfg=Grey cterm=italic guifg=Grey30

" Mouse support
set mouse=a
" Copy/Paste (Yank/Paste) via system clipboard
set clipboard+=unnamedplus

" GUI styling
set guifont=FuraCode\ Nerd\ Font:h14

" Escape '-- TERMINAL --' mode with ESC
tnoremap <Esc> <C-\><C-n>

" Fix for Emanote
set backupcopy=yes
