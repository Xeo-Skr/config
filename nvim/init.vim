set nocompatible
filetype off

"plugins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/NERDTree'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
"Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'arakashic/chromatica.nvim'
Plug 'sheerun/vim-polyglot'

"completion
"Plug 'roxma/nvim-completion-manager'
"Plug 'roxma/ncm-clang'
"Plug 'roxma/nvim-cm-racer'
"Plug 'racer-rust/vim-racer'

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Valloric/vim-operator-highlight'
Plug 'ntpeters/vim-better-whitespace'

"colorscheme
"Plug 'chriskempson/vim-tomorrow-theme'
Plug 'hallzy/lightline-onedark'
Plug 'joshdick/onedark.vim'

call plug#end()

"filetype plugin indent on "load filetype-sspecific indent files with plugin support

set shell=/bin/bash

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"colorscheme
syntax enable "enable syntax processing
colorscheme onedark "colorscheme type


"256 color terminal
set t_Co=256
let base16colorspace=256

set shiftwidth=2
set list
if !empty($EPITECH_PATH) && getcwd() =~ $EPITECH_PATH
  set noexpandtab
  set tabstop=2
  set softtabstop=2
  set listchars=tab:\|\ ,trail:~
  set cino+=g0
else
  set expandtab
  set listchars=tab:..,trail:~
endif

set autoindent "automatic indentation
set smartindent

set encoding=utf-8 "file encoding
set scrolloff=3
set showmode
set hidden  " allow buffer switching without saving
set wildmenu "visual autocomplete for command menu
set wildmode=list:longest
set visualbell
set ruler
set number "show line numbers
set backspace=indent,eol,start
set laststatus=2
set lazyredraw
"set undofile

set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
set list
set lcs+=space:·

let mapleader = ","

"search
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

"text width
set wrap
set textwidth=78
set formatoptions=qrn1
set linebreak

"backup files
set noerrorbells
set noswapfile
set nobackup

"file format
set fileformat=unix
set fileformats=unix,dos

set shortmess+=c

"ale
let g:ale_sign_error = '✘>'
let g:ale_sign_warning = '-'

let g:ale_linters={
      \'c': ['clang'],
      \'cpp': ['clang'],
      \}

" autocmd BufEnter *.c*.cpp,*.h,*.hpp,*.hxx let g:ale_cpp_clang_options = join(ncm_clang#compilation_info()['args'], ' ')

let g:ale_c_clang_options='-O0 -W -Wall -Wextra -Wshadow'
let g:ale_cpp_clang_options='-O0 -W -Wall -Wextra -Wshadow -std=c++17'
let g:ale_rust_cargo_check_all_targets=0
let g:ale_rust_cargo_use_check=1

" default key mapping is annoying
let g:clang_make_default_keymappings = 0
" ncm-clang is auto detecting compile_commands.json and .clang_complete
" file
let g:clang_auto_user_options = ''

inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"`
imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-U>":"\<CR>")

func WrapClangGoTo()
	let cwd = getcwd()
	let info = ncm_clang#compilation_info()
	exec 'cd ' . info['directory']
	try
		let b:clang_user_options = join(info['args'], ' ')
		call g:ClangGotoDeclaration()
	catch
	endtry
	" restore
	exec 'cd ' . cwd
endfunc

" map to gd key
autocmd FileType c,cpp nnoremap <buffer> gd :call WrapClangGoTo()<CR>

""Cpp hilightinh
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

set showtabline=2  " always show tabline

let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'tabline': {
    \   'left': [ ['buffers'] ],
    \   'right': [ ['close'] ]
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ }
    \ }

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

"nerdtree
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
let g:NERDTreeChDirMode=2
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.lock']
"vim close when the only window remaining is nerdtree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"arrows hack
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

"easy escape
inoremap jj <Esc>

"window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <C-f> :FZF<CR>

"saving
nnoremap s :w<CR>

"buffer navigation
map <S-h> :bprev<CR>
map <S-j> :bprev<CR>
map <S-l> :bnext<CR>
map <S-k> :bnext<CR>
map <S-d> :bd<CR>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"save on focus lost
au FocusLost * :wa

"nvimrc loading..
set exrc
set secure
