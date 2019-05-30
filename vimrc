runtime! debian.vim

set nocompatible
set autoread
set backspace=indent,eol,start

set ignorecase
set smartcase
set incsearch
set wildmenu
set hlsearch
set showmatch

set number
set relativenumber
set scrolloff=5
set ruler
set hidden
set showmode

set foldmethod=marker
set foldcolumn=1

set background=dark

"set autoindent
"set smartindent
set smarttab
set expandtab
set shiftwidth=2
set tabstop=2
"set nowrap
"set textwidth=80
"set wrapmargin=80

set nobackup
set nowritebackup
set noswapfile

set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

if has("autocmd")
  filetype indent on
  filetype plugin on
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("syntax")
  syntax on
endif

let g:is_posix = 1

"if &t_Co >= 16
"  try | colorscheme solarized | catch | endtry
"else
"  try | colorscheme default | catch | endtry
"endif

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()
