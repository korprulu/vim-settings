" set nocompatible              " be iMproved, required
" filetype off                  " required

" Install vim-plug
" https://github.com/junegunn/vim-plug

call plug#begin()

Plug 'folke/tokyonight.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'stevearc/aerial.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'akinsho/toggleterm.nvim', { 'tag': 'v2.13.1'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v4.9.1' }
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'f-person/git-blame.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'saecki/crates.nvim', { 'tag': 'stable' } " Rust crates

" Copilot
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'

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
set termguicolors
colorscheme tokyonight

" netrw
nmap <leader>n :Lexplore<CR>
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 20

" vim-go
" gofumpt https://github.com/mvdan/gofumpt
let g:go_fmt_command = "gofmt"
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
nnoremap <silent> <C-[> :GoImplements<CR>

" tab navigation
nnoremap <S-Left> gT
nnoremap <S-Right> gt

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
nnoremap <leader>c :CopilotChatToggle<CR>

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
nmap ghpp <Plug>(GitGutterPrevHunk)
nmap ghn <Plug>(GitGutterNextHunk)

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
require('lualine').setup {
    sections = {
        lualine_c = {
            {
                "filename",
                path = 1,
            },
        },
    },
}

-- bufferline
require("bufferline").setup {
    options = {
        mode = "tabs",
        diagnostics = "coc",
        numbers = "ordinal",
    },
}

-- Copilot
require("CopilotChat").setup {
    -- model = "claude-3.5-sonnet",
    agent = 'copilot',
    window = {
        width = 0.4,
    },
    contexts = {
        file = {
            input = function(callback)
                local telescope = require("telescope.builtin")
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                telescope.find_files({
                    attach_mappings = function(prompt_bufnr)
                        actions.select_default:replace(function()
                        actions.close(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        callback(selection[1])
                        end)
                        return true
                    end,
                })
            end,
        },
    },
}

-- Aerial
require('aerial').setup {
    on_attach = function(bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', opts)
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', opts)
    end,
}
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')

-- crates.nvim
require('crates').setup()
