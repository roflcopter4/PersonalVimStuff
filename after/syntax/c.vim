syntax keyword cExtraNonStandard xmalloc xcalloc xrealloc xfree xreallocarray nmalloc nrealloc
syntax keyword cExtraNonStandard talloc talloc_array talloc_free talloc_realloc talloc_size talloc_realloc_size talloc_zero talloc_zero_size
syntax keyword cExtraNonStandard talloc_free_children talloc_named_const talloc_named
syntax keyword cExtraNonStandard TALLOC_FREE
syntax keyword cExtraOther       talloc_reference talloc_unlink talloc_total_size talloc_move talloc_reparent talloc_steal
syntax keyword cExtraOther       talloc_asprintf talloc_vasprintf talloc_strdup talloc_memdup talloc_autofree_context talloc_set_destructor
syntax keyword cExtraOther       brk sbrk

syntax keyword cStdlibFuncs1 malloc calloc realloc reallocarray
syntax match   cStdlibFuncs2 "\%(\.\|->\)\@3<!\<\%(free\)\%(\%(\s*)\)*\s*(\)\@="
syntax keyword cExtraConstants STDIN_FILENO STDOUT_FILENO STDERR_FILENO
syntax keyword cExtraConstants O_RDONLY O_WRONLY O_RDWR O_DIRECTORY O_BINARY
syntax keyword cExtraConstants O_APPEND O_ASYNC O_CLOEXEC O_CREAT O_DIRECT O_DIRECTORY O_DSYNC O_EXCL O_LARGEFILE
syntax keyword cExtraConstants O_NOATIME O_NOCTTY O_NOFOLLOW O_NONBLOCK O_NDELAY O_PATH O_SYNC O_TMPFILE O_TRUNC 
syntax keyword cExtraConstants PATH_MAX CLOCK_REALTIME MSG_WAITALL
syntax keyword cExtraConstants PROT_READ PROT_WRITE MAP_ANON MAP_PRIVATE MAP_SHARED

"******************************************************************************* 
"** ARDUINO **
syntax keyword arduinoConstant HIGH LOW INPUT OUTPUT LED_BUILTIN INPUT_PULLUP
syntax keyword arduinoConstant DEC BIN HEX OCT BYTE PI HALF_PI TWO_PI
syntax keyword arduinoConstant CHANGE FALLING RISING SERIAL DISPLAY LSBFIRST MSBFIRST 
syntax keyword arduinoConstant DEFAULT EXTERNAL INTERNAL INTERNAL1V1 INTERNAL2V56

syn keyword arduinoFunc analogReference analogRead analogWrite 
syn keyword arduinoFunc attachInterrupt detachInterrupt interrupts noInterrupts 
syn keyword arduinoFunc lowByte highByte bitRead bitWrite bitSet bitClear
syn keyword arduinoFunc millis micros delay delayMicroseconds 
syn keyword arduinoFunc pinMode digitalWrite digitalRead 
syn keyword arduinoFunc tone noTone pulseIn shiftOut 
syn keyword arduinoFunc digitalPinToInterrupt

syn keyword arduinoType boolean byte word String

highlight default link arduinoConstant Constant
highlight default link arduinoType     Type
highlight default link arduinoFunc     cAnsiFunction
"******************************************************************************* 

syntax keyword cC11Function    quick_exit at_quick_exit thrd_create thrd_exit mtx_lock mtx_unlock
syntax keyword cExtentionFunc  asprintf vasprintf dprintf vdprintf getline getdelim strsep strchrnul memmem
syntax keyword cExtentionFunc  isblank alloca strdup strdupa mkostemp mkostemps mkdtemp
syntax keyword cPosixFunction  link unlink mkfifo mkdir symlink mknod truncate ftruncate pipe
syntax keyword cPosixFunction  chown chmod lstat fstat fstat64 readlink sync syncfs fsync fdopen
syntax keyword cPosixFunction  fstatat openat fileno realpath dirname scandir
syntax keyword cPosixFunction  sysconf isatty ttyname sigaction
syntax keyword cPosixFunction  socket connect bind accept recv recvfrom send recvmsg sendmsg listen
syntax keyword cPosixFunction  gettimeofday clock_gettime mmap sbrk munmap
syntax keyword cPosixFunction  execl execle execlp execv execvp execvpe execve wait waitpid pause
syntax keyword cPosixFunction  posix_spawn posix_spawnp
syntax keyword cLinuxFunction  readlinkat mknodat mkdirat unlinkat mkfifoat linkat symlinkat fstatat64 fstatat dup3 pipe2

syntax match   cPosixFunction2 "\%(stat\)\>\%(\s*(\)\@="
syntax match   cForkAsKeyword  "\<v\=fork()"

syntax keyword cGNUAutoType __auto_type auto_type Auto
syntax keyword cAssertion assert
syntax keyword cMiscOperators __extension__ __typeof__

syn keyword	cExtraConstants	_MSC_VER __clang__ __cplusplus __GNUC_MINOR__ __FreeBSD__ _WIN32 _WIN64 WIN32 
syn keyword	cStorageClass	__restrict __inline __thread
syn match       cStdStruct	"\%(struct\s\)\@7<=\%(stat\)\>"
" syn keyword	cExtraTypes	pthread_t pthread_mutex_t pthread_attr_t pthread_cond_t pthread_cond_attr_t
" syn match       cStdStructs     "\%(struct\s\)\@7<=\%(timeval\|timespec\|stat\|dirent\|sockaddr\%(_un\)\=\)\>"

highlight def link cExtentionFunc	cAnsiFunction
highlight def link cExtraConstants	Constant
highlight def link cExtraNonStandard	cMiscFuncs
highlight def link cStdStruct		Type
highlight def link cGNUAutoType		C_Struct
highlight def link cMiscOperators	Operator
highlight def link cPosixFunction	cAnsiFunction
highlight def link cStdlibFuncs		cMiscFuncs
highlight def link cStdlibFuncs1	cStdlibFuncs
highlight def link cStdlibFuncs2	cStdlibFuncs
highlight! link cSizeOf Keyword
highlight! link cStructure		C_Struct
highlight! link cAssertion		Operator

highlight def link cC11Function		cAnsiFunction
highlight def link cPosixFunction2	cAnsiFunction
highlight def link cExtraOther		cAnsiFunction
highlight def link cLinuxFunction	cAnsiFunction
highlight def link cStdStructs		Type
highlight def link cForkAsKeyword	Keyword

syntax region cAttribute matchgroup=Operator containedin=cPreProc transparent	start='__attribute__\s*(('	skip=')\ze))'	end='))'

syntax region	cDefine	    matchgroup=c_preproc start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell
syntax region	cPreCondit  matchgroup=c_preproc start="^\s*\zs\(%:\|#\)\s*\(\%(if\%(\s0\)\@!\)\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend 
			\ contains=cComment,cCommentL,cCppString,cCharacter,cCppParen,cParenError,cNumbers,cCommentError,cSpaceError,cppOutIf,
			\_Neotags_c_d_cPreProcTag,cConstant,_tag_highlight_c_d_cPreProcTag,cExtraConstants
syntax match	cPreConditMatch	display "^\s*\zs\(%:\|#\)\s*\(else\|endif\)\>"

highlight! link cPreProc	c_preproc
highlight! link cCppSkip	c_preproc
highlight! link cPreConditMatch	c_preproc

syntax keyword		cDefined	defined		containedin=cPreCondit
highlight def link	cDefined	c_preproc
syntax region		cppError_	matchgroup=c_preproc	start=+^\s*#\s*\%(error\|warning\)+	end=+\n+	skip=+\\\n+
highlight def link	cppError_	String

highlight link cInclude		c_preproc
hi! link cSpecialCharacter	Special

" vim: sts=4 sw=0 noexpandtab
