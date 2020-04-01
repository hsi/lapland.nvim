" Theme: lapland
" Author: hsi
" License: MIT
" Source: https://github.com/hsi/lapland.vim

" Initialization {{{
highlight clear

if exists('syntax_on')
    syntax reset
endif

let g:colors_name='lapland'

set background=dark
" }}}

" User Interface {{{
" Reference: https://neovim.io/doc/user/syntax.html#highlight-groups

highlight ColorColumn  ctermbg=235  ctermfg=NONE cterm=NONE
highlight Conceal      ctermbg=NONE ctermfg=231  cterm=NONE
highlight Cursor       ctermbg=46   ctermfg=234  cterm=NONE
highlight CursorLine   ctermbg=235  ctermfg=NONE cterm=NONE
highlight CursorLineNr ctermbg=235  ctermfg=144  cterm=NONE
highlight DiffAdd      ctermbg=NONE ctermfg=46   cterm=NONE
highlight DiffDelete   ctermbg=NONE ctermfg=160  cterm=NONE
highlight Directory    ctermbg=NONE ctermfg=39   cterm=bold
highlight EndOfBuffer  ctermbg=NONE ctermfg=240  cterm=bold
highlight ErrorMsg     ctermbg=160  ctermfg=231  cterm=bold
highlight FoldColumn   ctermbg=NONE ctermfg=244  cterm=NONE
highlight Folded       ctermbg=NONE ctermfg=39   cterm=bold
highlight LineNr       ctermbg=NONE ctermfg=240  cterm=NONE
highlight MatchParen   ctermbg=NONE ctermfg=231  cterm=bold
highlight ModeMsg      ctermbg=NONE ctermfg=144  cterm=NONE
highlight MoreMsg      ctermbg=NONE ctermfg=244  cterm=bold
highlight MsgArea      ctermbg=NONE ctermfg=231  cterm=NONE
highlight MsgSeparator ctermbg=NONE ctermfg=244  cterm=NONE
highlight NonText      ctermbg=NONE ctermfg=144  cterm=bold
highlight Normal       ctermbg=234  ctermfg=253  cterm=NONE
highlight NormalFloat  ctermbg=235  ctermfg=231  cterm=NONE
highlight Pmenu        ctermbg=235  ctermfg=244  cterm=NONE
highlight PmenuSbar    ctermbg=235  ctermfg=NONE cterm=NONE
highlight PmenuSel     ctermbg=235  ctermfg=229  cterm=NONE
highlight PmenuThumb   ctermbg=244  ctermfg=NONE cterm=NONE
highlight Question     ctermbg=NONE ctermfg=231  cterm=bold
highlight QuickFixLine ctermbg=NONE ctermfg=231  cterm=bold
highlight Search       ctermbg=93   ctermfg=231  cterm=NONE
highlight SignColumn   ctermbg=NONE ctermfg=NONE cterm=bold
highlight SpecialKey   ctermbg=NONE ctermfg=229  cterm=bold
highlight SpellBad     ctermbg=NONE ctermfg=160  cterm=underline
highlight SpellLocal   ctermbg=NONE ctermfg=NONE cterm=underline
highlight SpellRare    ctermbg=NONE ctermfg=202  cterm=underline
highlight StatusLine   ctermbg=235  ctermfg=144  cterm=bold
highlight StatusLineNC ctermbg=235  ctermfg=244  cterm=NONE
highlight Substitute   ctermbg=46   ctermfg=234  cterm=bold
highlight TabLine      ctermbg=235  ctermfg=244  cterm=NONE
highlight TabLineFill  ctermbg=234  ctermfg=NONE cterm=NONE
highlight TabLineSel   ctermbg=235  ctermfg=144  cterm=NONE
highlight TermCursorNC ctermbg=244  ctermfg=234  cterm=NONE
highlight Title        ctermbg=NONE ctermfg=39   cterm=bold
highlight VertSplit    ctermbg=NONE ctermfg=244  cterm=NONE
highlight Visual       ctermbg=93   ctermfg=NONE cterm=NONE
highlight WarningMsg   ctermbg=NONE ctermfg=202  cterm=NONE
highlight Whitespace   ctermbg=160  ctermfg=231  cterm=NONE
highlight WildMenu     ctermbg=NONE ctermfg=229  cterm=NONE

highlight! link CursorColumn CursorLine
highlight! link CursorIM     Cursor
highlight! link DiffChange   Normal
highlight! link DiffText     DiffAdd
highlight! link IncSearch    Search
highlight! link NormalNC     Normal
highlight! link SpellCap     SpellBad
highlight! link TermCursor   Cursor
highlight! link VisualNOS    Visual
" }}}

" General Groups {{{
" Reference: https://neovim.io/doc/user/syntax.html#{group-name}

highlight Comment        ctermbg=NONE ctermfg=240  cterm=NONE

highlight Constant       ctermbg=NONE ctermfg=198  cterm=NONE
highlight String         ctermbg=NONE ctermfg=36   cterm=NONE
highlight Character      ctermbg=NONE ctermfg=46   cterm=NONE

highlight Identifier     ctermbg=NONE ctermfg=153  cterm=NONE

highlight Statement      ctermbg=NONE ctermfg=229  cterm=NONE
highlight Conditional    ctermbg=NONE ctermfg=229  cterm=bold
highlight Repeat         ctermbg=NONE ctermfg=229  cterm=bold
highlight Operator       ctermbg=NONE ctermfg=39   cterm=NONE
highlight Exception      ctermbg=NONE ctermfg=229  cterm=bold

highlight PreProc        ctermbg=NONE ctermfg=39   cterm=NONE

highlight Type           ctermbg=NONE ctermfg=39   cterm=bold

highlight Special        ctermbg=NONE ctermfg=231  cterm=NONE

highlight Underlined     ctermbg=NONE ctermfg=NONE cterm=underline

highlight Ignore         ctermbg=231  ctermfg=232  cterm=NONE

highlight Error          ctermbg=160  ctermfg=231  cterm=bold

highlight Todo           ctermbg=231  ctermfg=234  cterm=bold

highlight! link Number  Constant
highlight! link Boolean Constant
highlight! link Float   Constant

highlight! link Function Identifier

highlight! link Label   Statement
highlight! link Keyword Statement

highlight! link Include   PreProc
highlight! link Define    PreProc
highlight! link Macro     PreProc
highlight! link PreCondit PreProc

highlight! link StorageClass Type
highlight! link Structure    Type
highlight! link Typedef      Type

highlight! link SpecialChar    Special
highlight! link Tag            Special
highlight! link Delimiter      Special
highlight! link SpecialComment Special
highlight! link Debug          Special
" }}}

" Diff
highlight! link diffAdded DiffAdd
highlight! link diffRemoved DiffDelete
highlight! link diffChanged Statement

" Git Commit
highlight! link gitcommitBranch Special
highlight! link gitcommitType Normal
highlight! link gitcommitHeader Type
highlight! link gitcommitFile Identifier
highlight! link gitcommitArrow Operator

" vim: foldmethod=marker
