" Vim color file

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

"colorscheme default
let g:colors_name = "userdefault"

hi Comment       ctermfg=241    ctermbg=NONE
hi VertSplit     ctermfg=236    ctermbg=248
hi StatusLine    ctermfg=236    ctermbg=248
hi StatusLineNC  ctermfg=236    ctermbg=242
hi ColorColumn   ctermfg=NONE   ctermbg=235

hi Folded        ctermfg=247    ctermbg=NONE
hi FoldColumn    ctermfg=247    ctermbg=NONE

hi LineNr        ctermfg=250    ctermbg=NONE
hi LineNrAbove   ctermfg=239    ctermbg=NONE
hi LineNrBelow   ctermfg=239    ctermbg=NONE

hi Pmenu         ctermfg=250   ctermbg=236
hi PmenuSel      ctermfg=255   ctermbg=172

