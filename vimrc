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
Plugin 'm2mdas/phpcomplete-extended'
Plugin 'm2mdas/phpcomplete-extended-laravel'
Plugin 'm2mdas/phpcomplete-extended-symfony'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'klen/python-mode'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'marijnh/tern_for_vim'
Plugin 'Shougo/unite.vim'
Plugin 'bling/vim-airline'
Plugin 'kchmck/vim-coffee-script'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'fatih/vim-go'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-markdown'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'vim-ruby/vim-ruby'
Plugin 'Shougo/vimproc.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

" airline font
let g:airline_powerline_fonts = 1
set background=dark

if has("gui_macvim")
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

" Vim sessions default to capturing all global options, which includes the 'runtimepath' that pathogen.vim manipulates.
" This can cause other problems too, so I recommend turning that behavior off
set sessionoptions-=options

" ========
" encoding
" ========
set encoding=utf-8
set fileencodings=utf-8,default


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

set sessionoptions-=options

" map key
map <leader>n :NERDTreeToggle<CR>
map <c-f> :call JsBeautify()<cr>

" jshint2
let jshint2_save = 1

" pymode
let g:pymode = 1

" vim-go
let g:go_fmt_command = "goimports"

" tagbar
nnoremap <silent><F7> :TagbarToggle<CR>

" vim-php-namespace
" Import classes (add use statements)
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>
" Make class names fully qualified
inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
noremap <Leader>e :call PhpExpandClass()<CR>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" phpcomplete-extended
autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
let g:phpcomplete_index_composer_command = '/usr/local/bin/composer'
" supertab
let g:SuperTabDefaultCompletionType = "context"
