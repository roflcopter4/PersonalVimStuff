syntax keyword cExtraNonStandard xmalloc xcalloc xrealloc xfree xreallocarray nmalloc nrealloc
syntax keyword cStdlibFuncs1 malloc calloc realloc reallocarray
syntax match   cStdlibFuncs2 "\%(\.\|->\)\@3<!\<\%(free\)\%(\%(\s*)\)*\s*(\)\@="
syntax keyword cExtraConstants STDIN_FILENO STDOUT_FILENO STDERR_FILENO
syntax keyword cExtraConstants O_RDONLY O_WRONLY O_RDWR
syntax keyword cExtraConstants O_APPEND O_ASYNC O_CLOEXEC O_CREAT O_DIRECT O_DIRECTORY O_DSYNC O_EXCL O_LARGEFILE
syntax keyword cExtraConstants O_NOATIME O_NOCTTY O_NOFOLLOW O_NONBLOCK O_NDELAY O_PATH O_SYNC O_TMPFILE O_TRUNC 
syntax keyword cExtraConstants PATH_MAX

syntax keyword cExtentionFunc  asprintf vasprintf getline getdelim strsep memmem alloca isblank strchrnul
syntax keyword cPosixFunction  link unlink mkfifo mkdir symlink mknod truncate ftruncate pipe
syntax keyword cPosixFunction  chown chmod stat lstat fstat fstat64 readlink sync syncfs fsync fdopen
syntax keyword cPosixFunction  fstatat openat
syntax keyword cPosixFunction  sysconf isatty ttyname sigaction socket connect
syntax keyword cPosixFunction  realpath dirname scandir
" syntax keyword cLinuxFunction  readlinkat mknodat mkdirat unlinkat mkfifoat linkat symlinkat fstatat64 fstatat dup3

syntax keyword cGNUAutoType __auto_type auto_type

syntax keyword cAssertion assert
syntax keyword cMiscOperators __extension__ 
" syntax region  cGnuExpressionStatement transparent matchgroup=cGnuStatementStartEnd start="({" end=")}" containedin=ALL

syn keyword	cExtraConstants	_MSC_VER __clang__ __cplusplus __GNUC_MINOR__ __FreeBSD__ _WIN32 _WIN64 WIN32 
syn keyword	cStorageClass	__restrict __inline __thread
syn keyword	CExtraTypes	pthread_t pthread_mutex_t

" highlight def link cExtraConstants	Constant
highlight def link cExtentionFunc	cAnsiFunction
highlight def link cExtraConstants	Constant
highlight def link cExtraNonStandard	cMiscFuncs
highlight def link cExtraTypes		Type
highlight def link cGNUAutoType		C_Struct
highlight def link cMiscOperators	Operator
highlight def link cPosixFunction	cAnsiFunction
highlight def link cStdlibFuncs		cMiscFuncs
highlight def link cStdlibFuncs1	cStdlibFuncs
highlight def link cStdlibFuncs2	cStdlibFuncs
highlight! link cSizeOf Keyword
highlight! link cStructure		C_Struct
highlight! link cAssertion		Operator

" highlight def link cGnuStatementStartEnd Operator

syntax region cAttribute matchgroup=Operator containedin=cPreProc transparent	start='__attribute__\s*(('	skip=')\ze))'	end='))'


syntax region	cDefine		matchgroup=c_preproc start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell

"syntax region	cCppSkip	transparent matchgroup=Precondit contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cSpaceError,cCppSkip
"syntax region	cCppSkip    matchgroup=c_preproc start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>"
"hi! link cDefine		Macro
"hi link cCppSkip Macro
"hi link cFormat Special

"hi! link cPreProc Precondit

syntax region	cPreCondit  matchgroup=c_preproc start="^\s*\zs\(%:\|#\)\s*\(\%(if\%(\s0\)\@!\)\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend 
			\ contains=cComment,cCommentL,cCppString,cCharacter,cCppParen,cParenError,cNumbers,cCommentError,cSpaceError,cppOutIf,_Neotags_c_d_cPreProcTag,cConstant,_tag_highlight_c_d_cPreProcTag,cExtraConstants
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
hi! link cSpecialCharacter Special

" vim: sts=4 sw=0 noexpandtab
