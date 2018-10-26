syn match shBang	'^\%1l#\!.*$'
syn keyword shTodo	contained NOTE

if exists('b:is_kornshell')
    syn region shSetList oneline matchgroup=shSet start="\<\(local\|type\)\>\ze[^/]" end="$" matchgroup=shSetListDelim end="\ze[}|);&]" matchgroup=NONE end="\ze\s\+[#=]" contains=@shIdList
endif

if exists("b:is_bash")
 syn match	shTodo	contained		"\<\%(COMBAK\|FIXME\|TODO\|XXX\|NOTE\)\ze:\=\>"
else
 syn keyword	shTodo	contained		COMBAK FIXME TODO XXX NOTE
endif

syntax region shColonComment oneline matchgroup=shColon start=":" end="$"

hi def link shTodo	Todo
hi def link shBang	PreProc
hi def link shColonComment shComment
"hi link shLoop	Repeat
