" Pathogen load
execute pathogen#infect()
" execute pathogen#helptags()

filetype on
filetype plugin on
filetype indent on
syntax enable
set background=dark

" airline font
let g:airline_powerline_fonts = 1
set guifont=Meslo\ LG\ S\ for\ Powerline:h12

if has("gui_running")
    colorscheme solarized
else
    " enable airline tabline if opened in terminal
    let g:airline#extensions#tabline#enabled = 1
    colorscheme desert
endif

autocmd! bufwritepost .vimrc source ~/.vimrc

" ========
" encoding
" ========
set encoding=utf-8
set fileencodings=utf-8,big5,default


" =======
" General
" =======

set number      " display line number
set smartindent
set tabstop=4
set hlsearch     " search highlighting
set shiftwidth=4
set expandtab    " replace <TAB> with spaces
set ruler       " show the cursor position all the time
set autowrite
set cursorline
set modeline
set modelines=2
set backspace=2     " enable backspace to delete word (fix when upgrade to 7.4)
set showmode        " show current mode
set wildmenu        " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

" supertab
let g:SuperTabDefaultCompletionType = "context"

set sessionoptions-=options

" map key
map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <leader>n :NERDTreeToggle<CR>
nmap <leader>a <Esc>:Ack!
map <c-f> :call JsBeautify()<cr>

" used after vimgrep
nmap <ESC>n :cnext<CR>
nmap <ESC>p :cprevious<CR>

" switch tab
map <C-Left> :tabprevious<CR>
imap <C-Left> <ESC>:tabprevious<CR>
map <C-Right> :tabnext<CR>
imap <C-Right> <ESC>:tabnext<CR>

" jshint2
let jshint2_save = 1

" pymode
let g:pymode = 1

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
    autocmd filetype *
        \ if &omnifunc == "" |
        \ setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
endif

" vim-go
let g:go_fmt_command = "goimports"

nnoremap <silent><F7> :TagbarToggle<CR>
