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
set guifont=Inconsolata\ 12
" autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview
set sessionoptions=tabpages
" enable backspace to delete word (fix when upgrade to 7.4)
set backspace=2

" map key
map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <leader>n :NERDTreeToggle<CR>
nmap <leader>a <Esc>:Ack!

" used after vimgrep
nmap <ESC>n :cnext<CR>
nmap <ESC>p :cprevious<CR>

" switch tab
map <C-Left> :tabprevious<CR>
imap <C-Left> <ESC>:tabprevious<CR>
map <C-Right> :tabnext<CR>
imap <C-Right> <ESC>:tabnext<CR>

" pymode
let g:pymode_run = 1
let g:pymode_run_key = '<leader>r'
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
let g:SuperTabClosePreviewOnPopupClose = 1

" pydiction
let g:pydiction_location = './.vim/bundle/pydiction/complete-dict'

" jshint2
let jshint2_save = 1

" show tab index in tabline
" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
highlight TabLineSel ctermfg=yellow ctermbg=darkblue
highlight TabLineFill ctermfg=Black

if exists("+showtabline")
    function MyTabLine()
      let s = ''
      let t = tabpagenr()
      let i = 1
      while i <= tabpagenr('$')
          let buflist = tabpagebuflist(i)
          let winnr = tabpagewinnr(i)
          let s .= '%' . i . 'T'
          let s .= (i == t ? '%1*' : '%2*')
          let s .= ' '
          let s .= '%#TabNum#'
          let s .= i . ')'
          let s .= ' %*'
          let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
          let file = bufname(buflist[winnr - 1])
          let file = fnamemodify(file, ':p:t')
          if file == ''
              let file = '[No Name]'
          endif
          let s .= file
          let i = i + 1
      endwhile
      let s .= '%T%#TabLineFill#%='
      let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
      return s
    endfunction
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif

