syntax keyword cExtraNonStandard xmalloc xcalloc xrealloc xfree xreallocarray nmalloc nrealloc
syntax keyword cStdlibFuncs malloc calloc realloc reallocarray free
syntax keyword cExtraConstants STDIN_FILENO STDOUT_FILENO STDERR_FILENO
syntax keyword cAnsiFunction	asprintf vasprintf getline getdelim strsep memmem alloca isblank
" syntax keyword cSizeOf sizeof

syn keyword	cExtraConstants	_MSC_VER
syn keyword	cStorageClass	__restrict __inline
syn keyword	CExtraTypes	pthread_t

" highlight def link cExtraConstants	Constant
highlight def link cExtraNonStandard	cMiscFuncs
highlight def link cStdlibFuncs		cMiscFuncs
highlight def link cExtraConstants	Number
highlight def link cExtraTypes		Type
highlight! link cSizeOf Keyword
highlight! link cStructure		C_Struct

syntax region cAttribute matchgroup=Operator containedin=cPreProc transparent	start='__attribute__\s*(('	skip=')\ze))'	end='))'


syntax region	cDefine		matchgroup=c_preproc start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell
"syntax region	cCppSkip	transparent matchgroup=Precondit contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cSpaceError,cCppSkip
"syntax region	cCppSkip    matchgroup=c_preproc start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>"
"hi! link cDefine		Macro
"hi link cCppSkip Macro
"hi link cFormat Special

"hi! link cPreProc Precondit

syntax region	cPreCondit  matchgroup=c_preproc start="^\s*\zs\(%:\|#\)\s*\(\%(if\%(\s0\)\@!\)\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend 
			\ contains=cComment,cCommentL,cCppString,cCharacter,cCppParen,cParenError,cNumbers,cCommentError,cSpaceError,cppOutIf,_Neotags_c_d_cPreProcTag
" syntax region	cPreCondit  matchgroup=c_preproc start="^\s*\zs\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=cComment,cCommentL,cCppString,cCharacter,cCppParen,cParenError,cNumbers,cCommentError,cSpaceError,cppOutIf
syntax match	cPreConditMatch	display "^\s*\zs\(%:\|#\)\s*\(else\|endif\)\>"

highlight! link cPreProc	c_preproc
highlight! link cCppSkip	c_preproc
highlight! link cPreConditMatch	c_preproc

syntax keyword		cDefined	defined		containedin=cPreCondit
highlight def link	cDefined	c_preproc

syntax region		cppError_	matchgroup=c_preproc	start=+^\s*#\s*error+	end=+\n+	skip=+\\\n+
highlight def link	cppError_	String


" highlight link cStorageClass	Keyword
" highlight link cStorageClass	Operator
highlight link cInclude		c_preproc

" vim: sts=4 sw=0 noexpandtab
