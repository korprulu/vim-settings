" Pathogen load
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin indent on
syntax on

" let g:pyflakes_use_quickfix = 0

set number
set smartindent
set tabstop=4
set hlsearch
set shiftwidth=4
set expandtab
set ruler
colorscheme desert
set fileencodings=utf-8,big5,default
set autowrite
set cursorline
set modeline
set modelines=2
set sessionoptions=tabpages
" autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <leader>n :NERDTreeToggle<CR>
nmap <leader>a <Esc>:Ack!

" pymode
let g:pymode_run = 1
let g:pymode_run_key = 'R'
let g:pymode_doc = 0 " disable pydoc plugin
let g:pymode_rope = 0
" let g:pymode_rope_enable_autoimport = 1
" Enable python folding
let g:pymode_folding = 1
" Auto fix vim python paths if virtualenv enabled
let g:pymode_virtualenv = 1
" Autoremove unused whitespaces
let g:pymode_utils_whitespaces = 1
" Enable pymode indentation
let g:pymode_indent = 1
" Enable pymode's custom syntax highlighting
let g:pymode_syntax = 1

" pydiction
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'

" supertab
let g:SuperTabClosePreviewOnPopupClose = 1
