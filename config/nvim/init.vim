set shadafile=NONE

set number
set relativenumber
set lazyredraw
set showmatch
set nowrap
set scrolloff=999
set sidescrolloff=8

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set dictionary=/usr/share/dict/words

if &t_Co >= 256
	colorscheme userdefault
endif

autocmd FileType sh,bash,zsh setlocal foldmethod=syntax foldcolumn=1 colorcolumn=80
autocmd FileType sh,bash,zsh let g:sh_fold_enabled=3
autocmd FileType make set noexpandtab

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
