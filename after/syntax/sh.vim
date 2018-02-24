syn match    shBang  '^\%1l#\!.*$'
hi def link  shBang  PreProc
highlight link shLoop Repeat

if exists('b:is_kornshell')
    syn region shSetList oneline matchgroup=shSet start="\<\(local\|type\)\>\ze[^/]" end="$"				matchgroup=shSetListDelim end="\ze[}|);&]" matchgroup=NONE end="\ze\s\+[#=]"	contains=@shIdList
endif

"hi link shParenError	NONE
"hi link shCommandSub	Special

"hi clear shCommandSub
"highlight clear shCaseError	
"highlight clear shCondError	
"highlight clear shCurlyError	
"highlight clear shDerefOpError	
"highlight clear shDerefWordError
"highlight clear shDoError	
"highlight clear shEsacError	
"highlight clear shIfError	
"highlight clear shInError	
"highlight clear shParenError	
"highlight clear shTestError	
