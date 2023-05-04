runtime! ftplugin/man.vim

set nocompatible
set backspace=indent,eol,start

let g:is_posix = 1
"let g:is_bash=1
"let g:is_sh=1
let g:sh_fold_enabled = 3

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
"set scrolloff=5
set nowrap
set sidescrolloff=999
set scrolloff=999
set showmode
set showmatch

set foldmethod=marker foldcolumn=1

autocmd FileType sh,bash,zsh setlocal foldmethod=syntax foldcolumn=1 colorcolumn=101
autocmd FileType man setlocal nonumber norelativenumber foldcolumn=0

set dictionary=/usr/share/dict/words

set shiftwidth=4
set tabstop=4 softtabstop=4

set wildmenu hlsearch incsearch

nnoremap <leader><Up> :resize +2<CR>
nnoremap <leader><Down> :resize -2<CR>
nnoremap <leader><Right> :vertical resize +2<CR>
nnoremap <leader><Left> :vertical resize -2<CR>

function StripTrailingWhitespace()
	if !&binary && &filetype != 'diff'
		normal mz
		%s/\s\+$//e
		normal `z
	endif
endfunction

autocmd BufWrite * :call StripTrailingWhitespace()

hi! ColorColumn  ctermfg=NONE ctermbg=8    cterm=NONE
hi! Comment      ctermfg=8    ctermbg=NONE cterm=NONE
hi! Folded       ctermfg=NONE ctermbg=NONE cterm=NONE
hi! FoldColumn   ctermfg=NONE ctermbg=NONE cterm=NONE
hi! LineNr       ctermfg=NONE ctermbg=NONE cterm=NONE
hi! Function     ctermfg=NONE ctermbg=NONE cterm=NONE
hi! String       ctermfg=1    ctermbg=NONE cterm=NONE

"autocmd FileType sh,bash,zsh colorscheme CustomShell
