" set nocompatible              " be iMproved, required
" filetype off                  " required

" Install vim-plug
" https://github.com/junegunn/vim-plug

call plug#begin()

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'maksimr/vim-jsbeautify'
Plug 'elzr/vim-json'
Plug 'justmao945/vim-clang'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'akinsho/toggleterm.nvim', { 'tag': 'v2.*'}

Plug 'github/copilot.vim'

" Avante
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" always the last
" - brew install font-hack-nerd-font
" - change terminal font to Hack Nerd Font
Plug 'nvim-tree/nvim-web-devicons'

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
set backspace=2  " enable backspace to delete word (fix when upgrade to 7.4)
set showmode     " show current mode
set wildmenu     " wild char completion menu
set splitbelow   " split window below
set splitright   " split window right
set background=dark
set wildignore=*.o,*.class,*.pyc " ignore these files while expanding wild chars
set sessionoptions-=options
colorscheme catppuccin

" netrw
nmap <leader>n :Lexplore<CR>
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 20

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

" vim-jsbeautify
autocmd FileType javascript noremap <buffer> <leader>f  :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <leader>f :call JsonBeautify()<cr>
autocmd FileType html noremap <buffer> <leader>f :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <leader>f :call CSSBeautify()<cr>

" tab navigation
nnoremap <C-Left> gT
nnoremap <C-Right> gt

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
let g:webdevicons_enable_ctrlp = 1

" local settings
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" gitgutter
let g:gitgutter_preview_win_floating = 0
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

lua << EOF
-- toggleterm
require("toggleterm").setup{
  open_mapping = [[<c-\>]],
  direction = 'float',
}
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

-- lualine
require('lualine').setup{}

-- bufferline
require("bufferline").setup{}

-- avante
require('avante_lib').load()
require('avante').setup {
  provider = 'copilot',
}
EOF
