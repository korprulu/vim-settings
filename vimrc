" set nocompatible              " be iMproved, required
" filetype off                  " required

" Install vim-plug
" https://github.com/junegunn/vim-plug

call plug#begin()

Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'maksimr/vim-jsbeautify'
Plug 'elzr/vim-json'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'justmao945/vim-clang'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'

" CopilotChat.nvim
Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }

" removed plugins
" Plugin 'aklt/plantuml-syntax'
" Plugin 'ervandew/supertab'
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'jelera/vim-javascript-syntax'
" Plugin 'hashivim/vim-terraform'
" Plugin 'vim-php/tagbar-phpctags.vim'
" Plugin 'leafgarland/typescript-vim'
" Plugin 'madox2/vim-ai'

" All of your Plugins must be added before the following line
call plug#end()            " required

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
nmap <leader>n :Explore<CR>
" inoremap { {}<Left>
" inoremap ( ()<Left>

" airline font
let g:airline_powerline_fonts = 1
set background=dark

if has("nvim")
    colorscheme vim
endif

if has("gui_running")
    " colorscheme solarized
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
let g:go_rename_command='gopls'
" let g:go_auto_sameids = 1
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
" autocmd BufWritePre *.go :GoLint
" let g:go_list_type = \"quickfix\"
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

" Coc
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" scroll down float window
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1, 1)\<cr>" : "\<Right>"
" scroll up float window
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0, 1)\<cr>" : "\<Right>"

command! -nargs=0 CocRename :normal! <Plug>(coc-rename)
command! -nargs=0 TsDef :call CocAction('runCommand', 'tsserver.goToSourceDefinition')
" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

autocmd BufWritePre *.ts :call CocAction('runCommand', 'editor.action.organizeImport')

" Copilot
imap <silent><script><expr> <C-A> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" typescript-vim
let g:typescript_indent_disable = 1

" ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
  \ 'AcceptSelection("t")': ['<cr>', '<c-t>'],
  \ }
let g:ctrlp_regexp = 1

" CopilotChat.nvim
lua << EOF
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
EOF
