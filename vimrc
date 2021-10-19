runtime! ftplugin/man.vim

set nocompatible
set backspace=indent,eol,start

let g:is_sh=1
let g:sh_fold_enabled=3

filetype indent plugin on

set hidden
set writebackup nobackup autoread
set viminfofile=NONE

syntax on
set background=dark

set lazyredraw
set number relativenumber
set ruler
set showcmd
set scrolloff=5
set showmode
set showmatch

set colorcolumn=80
set foldmethod=syntax foldcolumn=1

set shiftwidth=4
set tabstop=4 softtabstop=4

set wildmenu hlsearch incsearch

nnoremap <leader><Up> :resize +2<CR>
nnoremap <leader><Down> :resize -2<CR>
nnoremap <leader><Right> :vertical resize +2<CR>
nnoremap <leader><Left> :vertical resize -2<CR>

augroup ManPager
	autocmd!
	autocmd FileType man
		\ setlocal nonumber |
		\ setlocal norelativenumber |
		\ setlocal colorcolumn=0 |
		\ setlocal foldcolumn=0
augroup end

function StripTrailingWhitespace()
	if !&binary && &filetype != 'diff'
		normal mz
		%s/\s\+$//e
		normal `z
	endif
endfunction

autocmd BufWrite * :call StripTrailingWhitespace()
