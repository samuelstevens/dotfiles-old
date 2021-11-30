" Vim color file
" Maintainer:	Samuel Stevens <samuel.robert.stevens@gmail.com>
" Last Change:	2021 Nov 30

highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "brutal"

hi Normal cterm=NONE ctermfg=241 ctermbg=White

" syntax highlighting
hi Comment    cterm=bold ctermfg=240

hi Constant   cterm=NONE ctermfg=241
hi Identifier cterm=NONE ctermfg=241

hi Statement  cterm=NONE ctermfg=241

hi PreProc    cterm=NONE ctermfg=241
hi Type	      cterm=NONE ctermfg=241
hi Special    cterm=NONE ctermfg=241

hi Underlined cterm=NONE ctermfg=241
hi Ignore     cterm=NONE ctermfg=241
hi Error      cterm=NONE ctermfg=160 ctermbg=White
hi TODO       cterm=NONE ctermfg=166 ctermbg=White

hi LineNr      cterm=NONE ctermfg=245

" folding
hi Folded       ctermfg=240 ctermbg=White
hi FoldColumn   ctermfg=240 ctermbg=White

hi Pmenu             ctermfg=240 ctermbg=254
hi Search cterm=bold ctermfg=33 ctermbg=White
