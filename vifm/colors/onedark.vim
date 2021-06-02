" Onedark

<<<<<<< HEAD
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

=======
>>>>>>> a78b9882259ae6b26d5209472c06fe6395f922f3
" Reset all styles first
highlight clear

highlight Border	cterm=none	ctermfg=035	ctermbg=default

highlight TopLine	cterm=none	ctermfg=002	ctermbg=default
highlight TopLineSel	cterm=bold	ctermfg=002	ctermbg=015

highlight Win		cterm=none	ctermfg=250	ctermbg=default
highlight Directory	cterm=bold	ctermfg=004	ctermbg=default
highlight CurrLine	cterm=bold,inverse	ctermfg=default	ctermbg=default
highlight OtherLine	cterm=bold	ctermfg=default	ctermbg=default
highlight Selected	cterm=none	ctermfg=003	ctermbg=008

highlight JobLine	cterm=bold	ctermfg=250	ctermbg=008
highlight StatusLine	cterm=none	ctermfg=250	ctermbg=015
highlight ErrorMsg	cterm=bold	ctermfg=001	ctermbg=default
highlight WildMenu	cterm=bold	ctermfg=015	ctermbg=250
highlight CmdLine	cterm=none	ctermfg=007	ctermbg=default

highlight Executable	cterm=bold	ctermfg=002	ctermbg=default
highlight Link		cterm=bold	ctermfg=006	ctermbg=default
highlight BrokenLink	cterm=bold	ctermfg=001	ctermbg=default
highlight Device	cterm=bold,standout	ctermfg=000	ctermbg=011
highlight Fifo		cterm=none	ctermfg=003	ctermbg=default
highlight Socket	cterm=bold	ctermfg=005	ctermbg=default
