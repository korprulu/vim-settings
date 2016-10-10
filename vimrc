set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'editorconfig/editorconfig-vim'
Plugin 'othree/html5.vim'
Plugin 'Shutnik/jshint2.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'klen/python-mode'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'marijnh/tern_for_vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'fatih/vim-go'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-markdown'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

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
" set expandtab    " replace <TAB> with spaces
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

" map key
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
    colorscheme desert
endif


" jshint2
let jshint2_save = 1

" pymode
let g:pymode_folding = 0

" vim-go
let g:go_fmt_command = "goimports"

" tagbar
nnoremap <silent><F7> :TagbarToggle<CR>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" supertab
let g:SuperTabDefaultCompletionType = "context"

" syntastic
let g:syntastic_html_tidy_exec = "tidy5"

" vim-jsbeautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
