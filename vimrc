set nocompatible              " be iMproved, required
filetype off                  " required

" Install Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'preservim/tagbar'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'fatih/vim-go'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'elzr/vim-json'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'hashivim/vim-terraform'
Plugin 'aklt/plantuml-syntax'
Plugin 'justmao945/vim-clang'
" Plugin 'vim-php/tagbar-phpctags.vim'
Plugin 'ctrlpvim/ctrlp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

" ========
" encoding
" ========
set encoding=utf-8
set fileencodings=utf-8,default


" =======
" General
" =======

set number       " display line number
set smartindent
set tabstop=4
set hlsearch     " search highlighting
set shiftwidth=4
set expandtab    " replace <TAB> with spaces
set ruler        " show the cursor position all the time
set autowrite
set cursorline
" set modeline
" set modelines=2
set backspace=2  " enable backspace to delete word (fix when upgrade to 7.4)
set showmode     " show current mode
set wildmenu     " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set sessionoptions-=options

" key mapping
inoremap { {}<Left>
inoremap ( ()<Left>

" nerdtree
map <leader>n :NERDTreeToggle<CR>

" airline font
let g:airline_powerline_fonts = 1
set background=dark

let s:uname = system("uname -s")
if has("gui_macvim") || s:uname == "Darwin"
    set guifont=Meslo\ LG\ S\ for\ Powerline:h12
else
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
endif

if has("gui_running")
    colorscheme solarized
else
    " enable airline tabline if opened in terminal
    let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#tab_nr_type = 1
endif

" vim-go
" gofumpt https://github.com/mvdan/gofumpt
let g:go_fmt_command = "gofumpt"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
autocmd BufWritePre *.go :GoLint
" let g:go_list_type = "quickfix"
" autocmd FileType go set omnifunc=gocomplete#Complete

" tagbar
nnoremap <silent><F7> :TagbarToggle<CR>
let g:tagbar_width = 50
" tagbar for php
" let g:tagbar_phpctags_bin='/usr/local/bin/phpctags'
" let g:tagbar_phpctags_memory_limit = '512M'
"
" tagbar for golang
" install https://github.com/jstemmer/gotags

" supertab
let g:SuperTabDefaultCompletionType = "context"

" vim-jsbeautify
autocmd FileType javascript noremap <buffer> <leader>f  :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <leader>f :call JsonBeautify()<cr>
autocmd FileType html noremap <buffer> <leader>f :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <leader>f :call CSSBeautify()<cr>

" vimgrep
map <leader>o :cn<cr>
map <leader>p :cp<cr>

" ensime
nnoremap <localleader>t :EnType<CR>
autocmd BufWritePost *.scala silent :EnTypeCheck

" tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" plantuml
if !empty(expand(glob('.plantuml-exec-script')))
	let g:plantuml_executable_script=$HOME.'/.plantuml-exec-script'
endif

" terraform
" let g:terraform_fmt_on_save = 1
