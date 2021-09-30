" Basic Settings
syntax on 	 	    " Basic Syntax
set noerrorbells 	" No error bell
set nu	 	 	    " Numbers on lines
set norelativenumber
set nohlsearch
set mouse=a 	 	" Mouse support
set ignorecase	 	" Ignores case sensitive
set smartcase
set termguicolors	" Enable true color
"set t_Co=256
set nowrap
set incsearch
set encoding=utf-8
set cursorline
set nocursorcolumn
set formatoptions-=cro
set nocompatible
set splitbelow
set splitright
set iskeyword+=- " Treats dash separated words as one
"set noshowmode " Stops showing current vim mode
set signcolumn=yes
set updatetime=300
set shortmess+=c
set whichwrap+=h,l " Move to next line
set scrolloff=8

" Use system Clipboard
set clipboard=unnamedplus

" Tab Settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Autocomplete
set wildmode=longest,list,full
