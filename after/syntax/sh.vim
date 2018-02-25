syn match shBang	'^\%1l#\!.*$'
syn keyword shTodo	contained TODO FIXME XXX NOTE

if exists('b:is_kornshell')
    syn region shSetList oneline matchgroup=shSet start="\<\(local\|type\)\>\ze[^/]" end="$" matchgroup=shSetListDelim end="\ze[}|);&]" matchgroup=NONE end="\ze\s\+[#=]" contains=@shIdList
endif


hi def link shTodo	Todo
hi def link  shBang	PreProc
hi link shLoop	Repeat

