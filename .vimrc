" Set <space> as the leader key
" See `:help mapleader`
let mapleader=' '
let maplocalleader = ' '

" [[ Setting Neovim default options ]]
filetype on
syntax on
set autoindent autoread background=dark
set backspace=indent,eol,start belloff=all
set display=lastline encoding=utf-8 hidden
set history=10000 incsearch
set nojoinspaces laststatus=2 ruler
set showcmd smarttab nostartofline
set switchbuf=uselast wildmenu "wildoptions=pum,tagfile

" Make line numbers default
set number

"set relativenumber
set mouse=a

" Don't show the mode, since it's already in the status line
set noshowmode

" Sync clipboard between OS and Vim.
set clipboard=unnamedplus

" Enable break indent
set breakindent

"  NOTE: See `:help undofile` and `:help undodir` for more information
"    You may change the undodir to another directory you prefer
"set undodir=~/.local/state/vim/undo//
"set undofile

" Case-insensitive searching UNLESS \C or capital in search
set ignorecase
set smartcase

" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Keep signcolumn on by default
set signcolumn=yes

" Decrease update time
set updatetime=250

" Decrease mapped sequence wait time
" Displays vim-which-key sooner
set timeoutlen=300

" Configure how new splits should be opened
set splitright
set splitbelow

" Sets how Vim will display certain whitespace characters in the editor.
set list
set listchars=tab:»\ ,trail:·,nbsp:␣
" Use the following settings if you do not want unicode characters
"set listchars=tab:>\ ,trail:-,nbsp:+

" Show which line your cursor is on
set cursorline

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=10

" if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
" instead raise a dialog asking if you wish to save the current file(s)
" See `:help 'confirm'`
set confirm

" [[ Install plugins ]]
call plug#begin()
" Detect tabstop and shiftwidth automatically
Plug 'tpope/vim-sleuth'

" "gc" to comment visual regions/lines
Plug 'tpope/vim-commentary'

" Adds git related signs to the gutter
Plug 'airblade/vim-gitgutter'

" Useful plugin to show you pending keybinds.
Plug 'liuchengxu/vim-which-key'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Enable LSP
Plug 'prabirshrestha/vim-lsp'
" Install language servers and configure them for vim-lsp
Plug 'mattn/vim-lsp-settings'

" Autocompletion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Colorscheme
Plug 'ghifarit53/tokyonight-vim'

" Set airline as statusline
Plug 'vim-airline/vim-airline'

" Linting fallback if coc not active
Plug 'dense-analysis/ale' 

" Auto close brackets
Plug 'jiangmiao/auto-pairs'

" Mostly out-of-the-box for many languages
Plug 'sheerun/vim-polyglot'

" Nerd tree
Plug 'preservim/nerdtree'
call plug#end()


" [[ Configure plugins ]]
" Set colorscheme
set termguicolors                   " Enable RGB colors
let g:tokyonight_style = 'night'    " available: night, storm
let g:tokyonight_enable_italic = 0  " Disable italics in comments
colorscheme tokyonight

" [[ Configure vim-which-key ]]
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '<Space>'<CR>

" Document existing key chains
let g:which_key_map =  {}
let g:which_key_map.s = { 'name' : '[S]earch' }
let g:which_key_map.h = { 'name' : 'Git [H]unk' }

" Set airline
" ─── Theme and Basic Settings ───
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tokyonight'

" Always show the statusline
set laststatus=2

" Enable tabline (shows open buffers)
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" ─── Enable useful extensions ───
let g:airline#extensions#branch#enabled = 1         " Git branch
let g:airline#extensions#hunks#enabled = 1          " Git changes
let g:airline#extensions#coc#enabled = 1            " LSP diagnostics (with coc.nvim)
let g:airline#extensions#virtualenv#enabled = 1     " Python venv name
let g:airline#extensions#whitespace#enabled = 0     " Disable trailing space warning if annoying

" ─── Customize the sections ───
" See `:help airline-sections`
let g:airline_section_a = airline#section#create(['mode'])
let g:airline_section_b = airline#section#create(['branch'])
let g:airline_section_c = airline#section#create(['%f'])
let g:airline_section_x = airline#section#create(['filetype'])
let g:airline_section_y = airline#section#create_right(['%l:%c'])
let g:airline_section_z = airline#section#create(['%p%%'])

" ─── Optional: Cleaner inactive windows ───
let g:airline_inactive_collapse = 1
let g:airline#extensions#tabline#show_buffers = 1

" ─── Optional: Shorten long paths ───
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" ─── Highlight tweak for tokyonight ───
" Makes Airline colors blend better with tokyonight theme
autocmd ColorScheme * hi! link airline_a_normal PmenuSel

" [[ Configure fzf.vim ]]
" See `:help fzf-vim`
nmap <leader>sh :Helptags<CR>
let g:which_key_map.s.h = '[S]earch [H]elp'
nmap <leader>sk :Maps<CR>
let g:which_key_map.s.k = '[S]earch [K]eymaps'
nmap <leader>sf :Files<CR>
let g:which_key_map.s.f = '[S]earch [F]iles'
nmap <leader>sg :Rg<CR>
let g:which_key_map.s.g = '[S]earch by [G]rep'
nmap <leader>s. :History<CR>
let g:which_key_map.s['.'] = '[S]earch Recent Files ("." for repeat)'
nmap <leader><leader> :Buffers<CR>
let g:which_key_map[' '] = '[ ] Find existing buffers'

nmap <leader>/ :BLines<CR>
let g:which_key_map['/'] = '[/] Fuzzily search in current buffer'


" [[ Configure LSP ]]
" NOTE: Install new language server using `:LspInstallServer` in the filetype
" you are trying to install LSP for.
" For example, if you want LSP server for C/C++, type
" `:LspInstallServer clangd` in a C/C++ buffer.

" Performance related settings, requires Vim 8.2+
let g:lsp_use_native_client = 1
let g:lsp_semantic_enabled = 1

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  " Keymaps
  " These keybindings are default in Neovim
  nnoremap <buffer> [d <plug>(lsp-previous-diagnostic)
  nnoremap <buffer> ]d <plug>(lsp-next-diagnostic)
  " See `:help K` for why this keymap
  nnoremap <buffer> K <plug>(lsp-hover)
  nnoremap <buffer> grn <plug>(lsp-rename)
  nnoremap <buffer> gra <plug>(lsp-code-action-float)
  nnoremap <buffer> grr <plug>(lsp-references)
  nnoremap <buffer> gri <plug>(lsp-implementation)
  nnoremap <buffer> gO <plug>(lsp-document-symbol-search)
  nnoremap <buffer> <C-s> <plug>(lsp-signature-help)

  " Other useful functions
  nnoremap <buffer> grd <plug>(lsp-definition)
  " In C, this would take you to the header file
  nnoremap <buffer> grD <plug>(lsp-declaration)
  nnoremap <buffer> grt <plug>(lsp-peek-type-definition)
  nnoremap <buffer> gW <plug>(lsp-workspace-symbol-search)

  " Formatting
  let g:lsp_format_sync_timeout = 1000
  nnoremap <buffer> <leader>f <plug>(lsp-document-format)
  let g:which_key_map.f = '[F]ormat buffer'
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" [[ Configure completion ]]
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>""

let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview


" The line beneath this is called `modeline`. See `:help modeline`
" vim: ts=2 sts=2 sw=2 et

