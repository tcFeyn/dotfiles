" Center Screen on Insert Mode
autocmd InsertEnter * norm zz

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
