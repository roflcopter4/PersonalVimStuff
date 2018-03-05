syn match	zshVariableDef2		"\<\([bwglsav]:\)\=[a-zA-Z0-9.!@_%+,]*\ze="


syn region shEmbeddedEcho contained matchgroup=shStatement start="\<print\>" skip="\\$" matchgroup=shEchoDelim end="$" matchgroup=NONE end="[<>;&|`)]"me=e-1 end="\d[<>]"me=e-2 end="\s#"me=e-2 contains=shNumber,shExSingleQuote,shSingleQuote,shDeref,shDerefSimple,shSpecialVar,shOperator,shExDoubleQuote,shDoubleQuote,shCharClass,shCtrlSeq


syn region shDblBrace matchgroup=Delimiter start="\[\["	skip=+\%(\\\\\)*\\$+ end="\]\]"	contains=@shTestList,shAstQuote,shNoQuote,shComment
"syn cluster shIfList	contains=@shLoopList,shDblBrace,shDblParen,shFunctionKey,shFunctionOne,shFunctionTwo

hi def link shDblBrace		Delimiter

"syn match shOperator		"\[[[^:]\|\]]" contained
"syn match shOperator "\[\[\|\]\]\|\[\|\]"

"hi def link  zshVariable  Identifier
"hi def link  zshVariableDef  Identifier

hi def link  zshVariableDef2	Identifier
hi def link shStatement		Operator
hi! def link zshOperator	Operator
hi! def link shOperator		Operator
hi! def link zshDelimiter	Conditional
