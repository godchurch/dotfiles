" Vim color file

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

"colorscheme default
let g:colors_name = "userdefault"

hi Comment       ctermfg=238     ctermbg=NONE
hi VertSplit     ctermfg=7     ctermbg=NONE
hi StatusLine    ctermfg=236   ctermbg=15
hi StatusLineNC  ctermfg=236   ctermbg=7
hi ColorColumn   ctermfg=NONE  ctermbg=8

hi Folded        ctermfg=7     ctermbg=NONE
hi FoldColumn    ctermfg=7     ctermbg=NONE

hi LineNr        ctermfg=15    ctermbg=NONE
hi LineNrAbove   ctermfg=8     ctermbg=NONE
hi LineNrBelow   ctermfg=8     ctermbg=NONE

hi Pmenu         ctermfg=7     ctermbg=8
hi PmenuSel      ctermfg=8     ctermbg=11

hi TabLineFill   ctermfg=236   ctermbg=1
hi TabLine       ctermfg=7     ctermbg=236
hi TabLineSel    ctermfg=15    ctermbg=8
