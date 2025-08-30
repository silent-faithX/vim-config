" ---------------------------
" Vim Configuration (VS Code + Onedark + Git)
" ---------------------------

syntax on
filetype plugin indent on
set encoding=utf-8
set number relativenumber
set cursorline
set mouse=a
set termguicolors
highlight Terminal guifg=White guibg=Black
"highlight Normal ctermbg=None guibg=NONE
"highlight! link TermCursor Cursor
"highlight! TermCursorNC guibg=Grey guifg=Black
set tabstop=4 shiftwidth=4 expandtab smartindent
set guifont=FiraCode\ Nerd\ Font:h16
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
set guicursor=n-v-c:block,i-ci:ver25,r-cr:hor20,o:hor50
set guicursor=a:ver25

" Search
set ignorecase smartcase hlsearch incsearch
set laststatus=2 showmode
" Tab name
set title
set titlestring=vim-\ %t

" ---------------------------
" Plugin Manager (vim-plug)
" ---------------------------
call plug#begin('~/.vim/plugged')

" Theme Toktonight
Plug 'ghifarit53/tokyonight-vim'
" File Tree
Plug 'preservim/nerdtree'
" Terminal inside Vim
Plug 'voldikss/vim-floaterm'
" GitHub Copilot
Plug 'github/copilot.vim'
" Git Features
Plug 'tpope/vim-fugitive'        " Git commands
Plug 'airblade/vim-gitgutter'    " Git diff in gutter
Plug 'junegunn/gv.vim'           " Git commit browser
" Lightline
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
" Completion (VSCode-like)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
" Vim-devicon
Plug 'ryanoasis/vim-devicons'
" Vim-Comment
Plug 'tpope/vim-commentary'

call plug#end()

" ---------------------------
" Theme Setup
" ---------------------------
set termguicolors

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight
" ---------------------------
" File Tree Keymap
" ---------------------------
nnoremap <C-b> :NERDTreeToggle<CR>
" Enable devicons
let g:webdevicon_enable = 1
let g:webdevicon_enable_nerdtree = 1
let g:webdevicon_enable_ctrlp = 1
" File tree config
" Hide help text and only show directory + files
let NERDTreeMinimalUI=1

" Don’t show extra info (like permissions, size)
let NERDTreeDirArrows=1

" Ignore certain files (optional, like VSCode does by default) -- Your Choice
" let NERDTreeIgnore=['\.o$', '\~$', '\.exe$', '\.dll$', '\.pyc$', '__pycache__']


" ---------------------------
" Terminal Keymaps
" ---------------------------
" Floaterm settings
let g:floaterm_position = 'bottom'   " always open at bottom
let g:floaterm_height = 0.3          " 30% of screen height like VSCode
let g:floaterm_width = 1.0           " full width
let g:floaterm_title = ''            " no title bar (clean look)
let g:floaterm_autoclose = 1         " close when process exits

" Keymaps (VSCode style)
nnoremap <C-`> :FloatermToggle<CR>
tnoremap <C-`> <C-\><C-n>:FloatermToggle<CR>

" Create new terminal
nnoremap <leader>tn :FloatermNew<CR>
" Next terminal (like VSCode terminal tabs)
nnoremap <leader>tl :FloatermNext<CR>
" Previous terminal
nnoremap <leader>tp :FloatermPrev<CR>
" Kill current terminal
nnoremap <leader>tk :FloatermKill<CR>

" =============================
" VSCode-like Key Mappings
" =============================

" Copy (Ctrl+C) in Visual mode
vnoremap <C-c> "+y

" Cut (Ctrl+X) in Visual mode
vnoremap <C-x> "+d

" Paste (Ctrl+V) in Normal/Visual/Insert modes
nnoremap <C-v> "+p
vnoremap <C-v> "+p
inoremap <C-v> <C-r>+

" Select All (Ctrl+A) in Normal mode
nnoremap <C-a> ggVG

" Undo (Ctrl+Z)
nnoremap <C-z> u
inoremap <C-z> <C-o>u

" Redo (Ctrl+Y)
nnoremap <C-y> <C-r>
inoremap <C-y> <C-o><C-r>

" Save (Ctrl+S)
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a
vnoremap <C-s> <Esc>:w<CR>

" Quit (Ctrl+Q)
nnoremap <C-q> :q<CR>

" New Tab (Ctrl+T)
nnoremap <C-t> :tabnew<CR>

" Close Tab (Ctrl+W)
nnoremap <C-w> :tabclose<CR>

" Comment toggle (Ctrl+/) – requires commentary.vim or tcomment
nnoremap <C-/> :Commentary<CR>
vnoremap <C-/> :Commentary<CR>

" Toggle comment like VSCode (Ctrl+/)
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>


" ---------------------------
" GitHub Cpilot Setup
" ---------------------------
let g:copilot_enabled = 0
imap <C-i> <Plug>(copilot-suggest)
imap <CR>   <Plug>(copilot-accept)

" ---------------------------
" Git Features Setup
" ---------------------------

" Gitgutter signs
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 1

" Fugitive shortcuts
nnoremap <leader>gs :Git<CR>           " Git status
nnoremap <leader>gc :Git commit<CR>    " Git commit
nnoremap <leader>gp :Git push<CR>      " Git push
nnoremap <leader>gl :Git pull<CR>      " Git pull
nnoremap <leader>gb :Git blame<CR>     " Git blame
nnoremap <leader>gd :Gvdiffsplit<CR>   " Git diff view

" Git commit message highlighting
augroup gitcommit_highlight
autocmd!
autocmd FileType gitcommit syntax match gitcommitHeader /^.*/ containedin=gitcommitFirstLine
autocmd FileType gitcommit highlight gitcommitHeader guifg=#61afef ctermfg=Blue
augroup END

" Linghtline config
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

" ========================
" VSCode-like Enter behaviour coc.nvim Config
" ========================
" Enter = confirm completion if menu open, otherwise newline
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Tab = next suggestion, or expand snippet, or insert real Tab
inoremap <silent><expr> <Tab> 
      \ coc#pum#visible() ? coc#pum#next(1) : 
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : 
      \ CheckBackspace() ? "\<Tab>" : coc#refresh()

" Shift-Tab = previous suggestion
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Ctrl-Space = trigger completion
inoremap <silent><expr> <C-Space> coc#refresh()

" Helper function to handle backspace properly
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Show diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Go to definition / references
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

