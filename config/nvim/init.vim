set shadafile=NONE

set number
set relativenumber
set lazyredraw
set showmatch
set nowrap
set scrolloff=999
set sidescrolloff=8

autocmd FileType sh,bash,zsh setlocal foldmethod=syntax foldcolumn=1 colorcolumn=101

set dictionary=/usr/share/dict/words

set shiftwidth=4
set tabstop=4
set softtabstop=4

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
