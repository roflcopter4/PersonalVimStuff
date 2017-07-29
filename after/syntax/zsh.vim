syn match  zshVariableDef  "\<\([bwglsav]:\)\=[a-zA-Z0-9.!@_%+,]*\ze="

hi def link  zshVariable  Identifier
