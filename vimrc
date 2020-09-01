set nocompatible              " be iMproved, required
filetype off                  " required

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
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'fatih/vim-go'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-markdown'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'hashivim/vim-terraform'
Plugin 'scrooloose/vim-slumlord'
Plugin 'aklt/plantuml-syntax'

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
	let g:airline#extensions#tabline#tab_nr_type = 1
endif

" vim-go
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" let g:go_list_type = "quickfix"
" autocmd FileType go set omnifunc=gocomplete#Complete

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
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint'
let g:syntastic_html_checker = ['tidy']
let g:syntastic_html_tidy_exec = 'tidy'
let g:syntastic_scss_checker = ['scsslint']
let g:syntastic_scss_scsslint_exec = 'scss-lint'
let g:syntastic_go_checkers = ['golint', 'govet']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:syntastic_html_tidy_exec = "tidy5"
let g:syntastic_python_python_exec = "python3"

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

" terraform
let g:terraform_fmt_on_save = 1

" tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" tagbar
let g:tagbar_width = 50

" plantuml
let g:plantuml_executable_script='/Users/kevinchiu/.plantuml'
