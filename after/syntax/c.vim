syntax keyword cExtraNonStandard xmalloc xcalloc xrealloc xfree
syntax keyword cStdlibFuncs malloc calloc realloc free
syntax keyword cSizeOf sizeof

highlight def link cExtraNonStandard cMiscFuncs
highlight def link cStdlibFuncs      cMiscFuncs
highlight! link cSizeOf Keyword
