" Vim ftdetect plugin file
" File:           x4c.vim
" Maintainer:     roflcopter4

augroup x4c
    autocmd Syntax,BufNewFile,BufRead *.gy set filetype=goyacc
augroup END
