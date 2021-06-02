" Gruvbox

" Default = -1 = None, can be used for transparency or default color
" Black = 0
" Red = 1
" Green = 2
" Yellow = 3
" Blue = 4
" Magenta = 5
" Cyan = 6
" White = 7

" STYLES
" bold
" underline
" reverse or inverse
" standout
" none

" Reset all styles first
highlight clear

highlight Border	cterm=none	ctermfg=235	ctermbg=default

highlight TopLine	cterm=none	ctermfg=214	ctermbg=235
highlight TopLineSel	cterm=bold	ctermfg=214	ctermbg=237

highlight Win		cterm=none	ctermfg=223	ctermbg=default
"highlight OtherWin  cterm=none	ctermfg=223	ctermbg=236
highlight Directory	cterm=bold	ctermfg=109	ctermbg=default
highlight CurrLine	cterm=bold,inverse	ctermfg=default	ctermbg=default
highlight OtherLine	cterm=bold	ctermfg=default	ctermbg=235
highlight Selected	cterm=none	ctermfg=223	ctermbg=237

highlight JobLine	cterm=bold	ctermfg=116	ctermbg=238
highlight StatusLine	cterm=bold	ctermfg=144	ctermbg=236
highlight ErrorMsg	cterm=bold	ctermfg=167	ctermbg=default
highlight WildMenu	cterm=bold	ctermfg=235	ctermbg=144
highlight CmdLine	cterm=none	ctermfg=223	ctermbg=default

highlight Executable	cterm=bold	ctermfg=142	ctermbg=default
highlight Link		cterm=none	ctermfg=132	ctermbg=default
highlight BrokenLink	cterm=bold	ctermfg=167	ctermbg=default
highlight Device	cterm=none,standout	ctermfg=214	ctermbg=default
highlight Fifo		cterm=none	ctermfg=172	ctermbg=default
highlight Socket	cterm=bold	ctermfg=223	ctermbg=default
