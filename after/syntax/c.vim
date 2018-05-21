syntax keyword cExtraNonStandard xmalloc xcalloc xrealloc xfree
syntax keyword cStdlibFuncs malloc calloc realloc free
syntax keyword cSizeOf sizeof

highlight def link cExtraNonStandard cMiscFuncs
highlight def link cStdlibFuncs      cMiscFuncs
highlight! link cSizeOf Keyword

"syntax region cAattrIntern start='(' end=')' contains=ALL
syntax region cAttribute matchgroup=Operator	start='__attribute__\s*(('	skip=')\ze))'	end='))'
"highlight def link cAttribute String

syntax region	cDefine		matchgroup=c_preproc start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell
"syntax region	cCppSkip	transparent matchgroup=Precondit contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cSpaceError,cCppSkip
"syntax region	cCppSkip    matchgroup=c_preproc start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>"
"hi! link cDefine		Macro
"hi link cCppSkip Macro
"hi link cFormat Special

"hi! link cPreProc Precondit

syn region	cPreCondit	    matchgroup=c_preproc start="^\s*\zs\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=cComment,cCommentL,cCppString,cCharacter,cCppParen,cParenError,cNumbers,cCommentError,cSpaceError
syn match	cPreConditMatch	display "^\s*\zs\(%:\|#\)\s*\(else\|endif\)\>"

hi! link cPreProc c_preproc
hi! link cCppSkip c_preproc
"hi! link cDefine c_preproc
hi! link cPreConditMatch c_preproc

syntax keyword cDefined defined containedin=cPreCondit
hi def link cDefined c_preproc