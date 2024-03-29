"===== METHODS =====
" syntax match goStdlibMethods "\%(\%(\w\|[)\]]\)\.\)\@2<=\%(Lock\|Unlock\|Close\|Read\|Write\%(String\)\=\)\>"
hi def link goStdlibMethods cAnsiFunction

"===== CONSTANTS =====
syntax keyword goExtraConstants O_CREATE O_TRUNC O_SYNC O_RDONLY O_WRONLY O_RDWR O_APPEND O_EXECL
syntax keyword goExtraConstants SIGTERM SIGINT SIGKILL SIGPIPE
syntax keyword goExtraConstants MSG_DONTWAIT MSG_WAITALL O_CREAT 
syntax keyword goExtraConstants GOOS GOARCH Compiler
syntax match   goExtraConstants "\%(sys\%(call\)\=\.\)\@8<=\%(AF_UNIX\|SOCK_STREAM\|O_CREAT\|O_DSYNC\|O_NONBLOCK\)\>"
syntax match   goExtraConstants "\%(sys\%(call\)\=\.\)\@8<=\%(ENOENT\|EPERM\|ENOMEM\|EEXIST\)\>"
hi def link goExtraConstants Constant

"===== TYPES =====
" syntax match goStdlibTypes "\%(os\.\)\@3<=\%(File\|Process\|ProcessState\|ProcessAttr\|Signal\)\>"
" syntax match goStdlibTypes "\%(sync\.\)\@5<=\%(Mutex\|Cond\|Locker\|Pool\|Once\|WaitGroup\|RWMutex\)\>"
" syntax match goStdlibTypes "\%(sys\%(call\)\=\.\)\@8<=\%(ProcAttr\|Sockaddr\%(Unix\|Netlink\|Inet4\|Inet6\|Linklayer\|Netlink\)\=\|Timeval\|Timespec\|WaitStatus\|Stat_t\)\>"
" hi def link goStdlibTypes Type

"===== FUNCTIONS =====
" syntax match goStdlibFuncs "\%(os\.\)\@3<=\%(Open\|OpenFile\|LookupEnv\|Mkdir\|Executable\|IsExist\|Exit\|Environ\|Getwd\)\>"
" syntax match goStdlibFuncs "\%(runtime\.\)\@8<=\%(GOMAXPROCS\|GC\|Caller\%(s\|sframes\)\=\|NumCPU\)\>"
" syntax match goStdlibFuncs "\%(fmt\.\)\@4<=\%(Print\%(f\|ln\)\=\|Sprint\%(f\|ln\)\=\|Fprint\%(f\|ln\)\|Scan\%(f\|ln\)\=\)\>"
" syntax match goStdlibFuncs "\%(sys\%(call\)\=\.\)\@8<=\%(Open\|Close\|Read\|Write\|Connect\|Socket\|ForkExec\|Wait4\|Mkdir\|Fstat\|Unlink\|Seek\)\>"
" syntax match goStdlibFuncs "\%(strings\.\|bytes\.\)\@8<=\%(Join\|Split\|Index\%(Byte\|Rune\|Any\)\=\|HasPrefix\)\>"
" syntax match goStdlibFuncs "\%(ioutil\.\)\@7<=\%(Read\%(All\|Dir\|File\)\|WriteFile\)\>"
" syntax match goStdlibFuncs "\%(filepath\.\)\@9<=\%(Dir\|Base\|Ext\|Join\)\>"
" syntax keyword goStdlibFuncs Open OpenFile LookupEnv Mkdir Executable IsExist Exit Environ Getwd GOMAXPROCS Print Printf Println Fprint Fprintf Fprintln Sprint Sprintf Sprintln Close Read Write
hi def link goStdlibFuncs cAnsiFunction

syntax keyword goKeyword any

"===== OTHER =====
syntax match goExtraOperators "\<bytes.Equal\>"
hi def link goExtraOperators cAnsiFunction

" syntax keyword goMap map interface struct
" hi! link goMap boldOrange


syn match	goUserLabel	display "^\s*\zs\I\i*\s*:$"
syn match	goUserLabel	display ";\s*\zs\I\i*\s*:$"

hi def link goUserLabel Label


" syntax keyword goLightKeywords1 panic recover map interface struct
syntax keyword goLightKeywords1 map interface struct
syntax keyword goLightKeywords2 append make new len panic recover 
" hi! link goLightKeywords1 cMiscFuncs
" hi! link goLightKeywords2 boldOrange
hi! link goLightKeywords2 Operator
" hi! link goLightKeywords1 Structure
hi! link goLightKeywords1 boldOrange
highlight def link goKeyword Keyword

hi! link goOperator LightPinkR
