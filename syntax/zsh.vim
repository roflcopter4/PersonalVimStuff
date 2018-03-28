" Vim syntax file
" Language:		shell (sh) Korn shell (ksh) bash (sh)
" Maintainer:		Charles E. Campbell  <NdrOchipS@PcampbellAfamily.Mbiz>
" Previous Maintainer:	Lennart Schultz <Lennart.Schultz@ecmwf.int>
" Last Change:		Oct 02, 2017
" Version:		172
" URL:		http://www.drchip.org/astronaut/vim/index.html#SYNTAX_SH
" For options and settings, please use:      :help ft-sh-syntax
" This file includes many ideas from Eric Brunet (eric.brunet@ens.fr)

" quit when a syntax file was already loaded {{{1
if exists("b:current_syntax")
  finish
endif

" trying to answer the question: which shell is /bin/sh, really?
" If the user has not specified any of g:is_kornshell, g:is_bash, g:is_posix, g:is_sh, then guess.
let b:is_bash = 1
let b:is_kornshell = 1

" set up default g:sh_fold_enabled {{{1
" ================================
if !exists("g:sh_fold_enabled")
 let g:sh_fold_enabled= 0
elseif g:sh_fold_enabled != 0 && !has("folding")
 let g:sh_fold_enabled= 0
 echomsg "Ignoring g:sh_fold_enabled=".g:sh_fold_enabled."; need to re-compile vim for +fold support"
endif
if !exists("s:sh_fold_functions")
 let s:sh_fold_functions= and(g:sh_fold_enabled,1)
endif
if !exists("s:sh_fold_heredoc")
 let s:sh_fold_heredoc  = and(g:sh_fold_enabled,2)
endif
if !exists("s:sh_fold_ifdofor")
 let s:sh_fold_ifdofor  = and(g:sh_fold_enabled,4)
endif
if g:sh_fold_enabled && &fdm == "manual"
 " Given that	the	user provided g:sh_fold_enabled
 " 	AND	g:sh_fold_enabled is manual (usual default)
 " 	implies	a desire for syntax-based folding
 setl fdm=syntax
endif

" set up the syntax-highlighting iskeyword
if has("patch-7.4.1142")
 if exists("b:is_bash")
  exe "syn iskeyword ".&iskeyword.",-,:"
 else
  exe "syn iskeyword ".&iskeyword.",-"
 endif
endif

" Set up folding commands for shell {{{1
" =================================
if s:sh_fold_functions
 com! -nargs=* ShFoldFunctions <args> fold
else
 com! -nargs=* ShFoldFunctions <args>
endif
if s:sh_fold_heredoc
 com! -nargs=* ShFoldHereDoc <args> fold
else
 com! -nargs=* ShFoldHereDoc <args>
endif
if s:sh_fold_ifdofor
 com! -nargs=* ShFoldIfDoFor <args> fold
else
 com! -nargs=* ShFoldIfDoFor <args>
endif

" sh syntax is case sensitive {{{1
syn case match

" Clusters: contains=@... clusters {{{1
"==================================
syn cluster shErrorList	contains=shDoError,shIfError,shInError,shCaseError,shEsacError,shCurlyError,shParenError,shTestError,shOK
if exists("b:is_kornshell")
 syn cluster ErrorList add=shDTestError
endif
syn cluster shArithParenList	contains=shArithmetic,shCaseEsac,shComment,shDeref,shDo,shDerefSimple,shEcho,shEscape,shNumber,shOperator,shPosnParm,shExSingleQuote,shExDoubleQuote,shHereString,shRedir,shSingleQuote,shDoubleQuote,shStatement,shVariable,shAlias,shTest,shCtrlSeq,shSpecial,shParen,bashSpecialVariables,bashStatement,shIf,shFor
syn cluster shArithList	contains=@shArithParenList,shParenError
syn cluster shCaseEsacList	contains=shCaseStart,shCase,shCaseBar,shCaseIn,shComment,shDeref,shDerefSimple,shCaseCommandSub,shCaseExSingleQuote,shCaseSingleQuote,shCaseDoubleQuote,shCtrlSeq,@shErrorList,shStringSpecial,shCaseRange
syn cluster shCaseList	contains=@shCommandSubList,shCaseEsac,shColon,shCommandSub,shComment,shDo,shEcho,shExpr,shFor,shHereDoc,shIf,shHereString,shRedir,shSetList,shSource,shStatement,shVariable,shCtrlSeq
syn cluster shCommandSubList	contains=shAlias,shArithmetic,shCmdParenRegion,shCtrlSeq,shDeref,shDerefSimple,shDoubleQuote,shEcho,shEscape,shExDoubleQuote,shExpr,shExSingleQuote,shHereDoc,shNumber,shOperator,shOption,shPosnParm,shHereString,shRedir,shSingleQuote,shSpecial,shStatement,shSubSh,shTest,shVariable
syn cluster shCurlyList	contains=shNumber,shComma,shDeref,shDerefSimple,shDerefSpecial
syn cluster shDblQuoteList	contains=shCommandSub,shDeref,shDerefSimple,shEscape,shPosnParm,shCtrlSeq,shSpecial
syn cluster shDerefList	contains=shDeref,shDerefSimple,shDerefVar,shDerefSpecial,shDerefWordError,shDerefPSR,shDerefPPS
syn cluster shDerefVarList	contains=shDerefOff,shDerefOp,shDerefVarArray,shDerefOpError
syn cluster shEchoList	contains=shArithmetic,shCommandSub,shDeref,shDerefSimple,shEscape,shExpr,shExSingleQuote,shExDoubleQuote,shSingleQuote,shDoubleQuote,shCtrlSeq,shEchoQuote
syn cluster shExprList1	contains=shCharClass,shNumber,shOperator,shExSingleQuote,shExDoubleQuote,shSingleQuote,shDoubleQuote,shExpr,shDblBrace,shDeref,shDerefSimple,shCtrlSeq
syn cluster shExprList2	contains=@shExprList1,@shCaseList,shTest
syn cluster shFunctionList	contains=@shCommandSubList,shCaseEsac,shColon,shCommandSub,shComment,shDo,shEcho,shExpr,shFor,shHereDoc,shIf,shOption,shHereString,shRedir,shSetList,shSource,shStatement,shVariable,shOperator,shCtrlSeq
if exists("b:is_kornshell") || exists("b:is_bash")
 syn cluster shFunctionList	add=shDblBrace,shDblParen
endif
syn cluster shHereBeginList	contains=@shCommandSubList
syn cluster shHereList	contains=shBeginHere,shHerePayload
syn cluster shHereListDQ	contains=shBeginHere,@shDblQuoteList,shHerePayload
syn cluster shIdList	contains=shCommandSub,shWrapLineOperator,shSetOption,shDeref,shDerefSimple,shHereString,shRedir,shExSingleQuote,shExDoubleQuote,shSingleQuote,shDoubleQuote,shExpr,shCtrlSeq,shStringSpecial,shAtExpr
syn cluster shIfList	contains=@shLoopList,shDblBrace,shDblParen,shFunctionKey,shFunctionOne,shFunctionTwo
syn cluster shLoopList	contains=@shCaseList,@shErrorList,shCaseEsac,shConditional,shDblBrace,shExpr,shFor,shForPP,shIf,shOption,shSet,shTest,shTestOpr,shTouch
syn cluster shPPSRightList	contains=shComment,shDeref,shDerefSimple,shEscape,shPosnParm
syn cluster shSubShList	contains=@shCommandSubList,shCaseEsac,shColon,shCommandSub,shComment,shDo,shEcho,shExpr,shFor,shIf,shHereString,shRedir,shSetList,shSource,shStatement,shVariable,shCtrlSeq,shOperator
syn cluster shTestList	contains=shCharClass,shCommandSub,shCtrlSeq,shDeref,shDerefSimple,shDoubleQuote,shExDoubleQuote,shExpr,shExSingleQuote,shNumber,shOperator,shSingleQuote,shTest,shTestOpr
syn cluster shNoZSList	contains=shSpecialNoZS

" Echo: {{{1
" ====
" This one is needed INSIDE a CommandSub, so that `echo bla` be correct
syn region shEcho matchgroup=shStatement start="\<echo\>"  skip="\\$" matchgroup=shEchoDelim end="$" matchgroup=NONE end="[<>;&|()`]"me=e-1 end="\d[<>]"me=e-2 end="\s#"me=e-2 contains=@shEchoList skipwhite nextgroup=shQuickComment
syn region shEcho matchgroup=shStatement start="\<print\>" skip="\\$" matchgroup=shEchoDelim end="$" matchgroup=NONE end="[<>;&|()`]"me=e-1 end="\d[<>]"me=e-2 end="\s#"me=e-2 contains=@shEchoList skipwhite nextgroup=shQuickComment
syn match  shEchoQuote contained	'\%(\\\\\)*\\["`'()]'

" This must be after the strings, so that ... \" will be correct
syn region shEmbeddedEcho contained matchgroup=shStatement start="\<print\>" skip="\\$" matchgroup=shEchoDelim end="$" matchgroup=NONE end="[<>;&|`)]"me=e-1 end="\d[<>]"me=e-2 end="\s#"me=e-2 contains=shNumber,shExSingleQuote,shSingleQuote,shDeref,shDerefSimple,shSpecialVar,shOperator,shExDoubleQuote,shDoubleQuote,shCharClass,shCtrlSeq

" Alias: {{{1
" =====
if exists("b:is_kornshell") || exists("b:is_bash")
 syn match shStatement "\<alias\>"
 syn region shAlias matchgroup=shStatement start="\<alias\>\s\+\(\h[-._[:alnum:]]\+\)\@="  skip="\\$" end="\>\|`"
 syn region shAlias matchgroup=shStatement start="\<alias\>\s\+\(\h[-._[:alnum:]]\+=\)\@=" skip="\\$" end="="

 " Touch: {{{1
 " =====
 syn match shTouch	'\<touch\>[^;#]*'	skipwhite nextgroup=shComment contains=shTouchCmd,shDoubleQuote,shSingleQuote,shDeref,shDerefSimple
 syn match shTouchCmd	'\<touch\>'		contained
endif

" Error Codes: {{{1
" ============
if !exists("g:sh_no_error")
 syn match   shDoError "\<done\>"
 syn match   shIfError "\<fi\>"
 syn match   shInError "\<in\>"
 syn match   shCaseError ";;"
 syn match   shEsacError "\<esac\>"
 syn match   shCurlyError "}"
 syn match   shParenError ")"
 syn match   shOK	'\.\(done\|fi\|in\|esac\)'
 if exists("b:is_kornshell")
  syn match     shDTestError "]]"
 endif
 syn match     shTestError "]"
endif

" Options: {{{1
" ====================
syn match   shOption	"\s\zs[-+][-_a-zA-Z#@]\+"
syn match   shOption	"\s\zs--[^ \t$`'"|);]\+"

" File Redirection Highlighted As Operators: {{{1
"===========================================
syn match      shRedir	"\d\=>\(&[-0-9]\)\="
syn match      shRedir	"\d\=>>-\="
syn match      shRedir	"\d\=<\(&[-0-9]\)\="
syn match      shRedir	"\d<<-\="

" Operators: {{{1
" ==========
syn match   shOperator	"<<\|>>"		contained
syn match   shOperator	"[!&;|]"		contained
"syn match   shOperator	"\[[[^:]\|\]]"		contained
syn match   shOperator	"[-=/*+%]\=="		skipwhite nextgroup=shPattern
syn match   shPattern	"\<\S\+\())\)\@="	contained contains=shExSingleQuote,shSingleQuote,shExDoubleQuote,shDoubleQuote,shDeref

" Subshells: {{{1
" ==========
syn region shExpr  transparent matchgroup=shExprRegion  start="{" end="}"		contains=@shExprList2 nextgroup=shSpecialNxt
syn region shSubSh transparent matchgroup=shSubShRegion start="[^(]\zs(" end=")"	contains=@shSubShList nextgroup=shSpecialNxt

" Tests: {{{1
"=======
syn region shExpr	matchgroup=shRange start="\[" skip=+\\\\\|\\$\|\[+ end="\]" contains=@shTestList,shSpecial
syn region shTest	transparent matchgroup=shStatement start="\<test\s" skip=+\\\\\|\\$+ matchgroup=NONE end="[;&|]"me=e-1 end="$" contains=@shExprList1
syn region shNoQuote	start='\S'	skip='\%(\\\\\)*\\.'	end='\ze\s' end="\ze['"]"	contained contains=shDerefSimple,shDeref
syn match  shAstQuote	contained	'\*\ze"'	nextgroup=shString
syn match  shTestOpr	contained	'[^-+/%]\zs=' skipwhite nextgroup=shTestDoubleQuote,shTestSingleQuote,shTestPattern
syn match  shTestOpr	contained	"<=\|>=\|!=\|==\|=\~\|-.\>\|-\(nt\|ot\|ef\|eq\|ne\|lt\|le\|gt\|ge\)\>\|[!<>]"
syn match  shTestPattern	contained	'\w\+'
syn region shTestDoubleQuote	contained	start='\%(\%(\\\\\)*\\\)\@<!"' skip=+\\\\\|\\"+ end='"'	contains=shDeref,shDerefSimple,shDerefSpecial
syn match  shTestSingleQuote	contained	'\\.'	nextgroup=shTestSingleQuote
syn match  shTestSingleQuote	contained	"'[^']*'"
if exists("b:is_kornshell") || exists("b:is_bash")
 syn region  shDblBrace matchgroup=shDblDelim start="\[\["	skip=+\%(\\\\\)*\\$+ end="\]\]"	contains=@shTestList,shAstQuote,shNoQuote,shComment
 syn region  shDblParen matchgroup=shDblDelim start="(("	skip=+\%(\\\\\)*\\$+ end="))"	contains=@shTestList,shComment
endif

" Character Class In Range: {{{1
" =========================
syn match   shCharClass	contained	"\[:\(backspace\|escape\|return\|xdigit\|alnum\|alpha\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|tab\):\]"

" Loops: do, if, while, until {{{1
" ======
ShFoldIfDoFor syn region shDo	transparent	matchgroup=shConditional start="\<do\>" matchgroup=shConditional end="\<done\>"			contains=@shLoopList
ShFoldIfDoFor syn region shIf	transparent	matchgroup=shConditional start="\<if\_s" matchgroup=shConditional skip=+-fi\>+ end="\<;\_s*then\>" end="\<fi\>"	contains=@shIfList
ShFoldIfDoFor syn region shFor		matchgroup=shLoop start="\<for\ze\_s\s*\%(((\)\@!" end="\<in\>" end="\<do\>"me=e-2		contains=@shLoopList,shDblParen skipwhite nextgroup=shCurlyIn
ShFoldIfDoFor syn region shForPP	matchgroup=shLoop start='\<for\>\_s*((' end='))' contains=shTestOpr

if exists("b:is_kornshell") || exists("b:is_bash")
 syn cluster shCaseList	add=shRepeat
 syn cluster shFunctionList	add=shRepeat
 syn region shRepeat   matchgroup=shLoop   start="\<while\_s" end="\<in\_s" end="\<do\>"me=e-2	contains=@shLoopList,shDblParen,shDblBrace
 syn region shRepeat   matchgroup=shLoop   start="\<until\_s" end="\<in\_s" end="\<do\>"me=e-2	contains=@shLoopList,shDblParen,shDblBrace
 syn region shCaseEsac matchgroup=shConditional start="\<select\s" matchgroup=shConditional end="\<in\>" end="\<do\>" contains=@shLoopList
else
 syn region shRepeat   matchgroup=shLoop   start="\<while\_s" end="\<do\>"me=e-2		contains=@shLoopList
 syn region shRepeat   matchgroup=shLoop   start="\<until\_s" end="\<do\>"me=e-2		contains=@shLoopList
endif
syn region shCurlyIn   contained	matchgroup=Delimiter start="{" end="}" contains=@shCurlyList
syn match  shComma     contained	","

" Case: case...esac {{{1
" ====
syn match   shCaseBar	contained skipwhite "\(^\|[^\\]\)\(\\\\\)*\zs|"		nextgroup=shCase,shCaseStart,shCaseBar,shComment,shCaseExSingleQuote,shCaseSingleQuote,shCaseDoubleQuote
syn match   shCaseStart	contained skipwhite skipnl "("			nextgroup=shCase,shCaseBar
if exists("b:is_bash")
 ShFoldIfDoFor syn region  shCase	contained skipwhite skipnl matchgroup=shSnglCase start="\%(\\.\|[^#$()'" \t]\)\{-}\zs)"  end=";;" end=";&" end=";;&" end="esac"me=s-1 contains=@shCaseList nextgroup=shCaseStart,shCase,shComment
else
 ShFoldIfDoFor syn region  shCase	contained skipwhite skipnl matchgroup=shSnglCase start="\%(\\.\|[^#$()'" \t]\)\{-}\zs)"  end=";;" end="esac"me=s-1 contains=@shCaseList nextgroup=shCaseStart,shCase,shComment
endif
ShFoldIfDoFor syn region  shCaseEsac	matchgroup=shConditional start="\<case\>" end="\<esac\>"	contains=@shCaseEsacList

syn keyword shCaseIn	contained skipwhite skipnl in			nextgroup=shCase,shCaseStart,shCaseBar,shComment,shCaseExSingleQuote,shCaseSingleQuote,shCaseDoubleQuote
if exists("b:is_bash")
 syn region  shCaseExSingleQuote	matchgroup=shQuote start=+\$'+ skip=+\\\\\|\\.+ end=+'+	contains=shStringSpecial,shSpecial	skipwhite skipnl nextgroup=shCaseBar	contained
elseif !exists("g:sh_no_error")
 syn region  shCaseExSingleQuote	matchgroup=Error start=+\$'+ skip=+\\\\\|\\.+ end=+'+	contains=shStringSpecial	skipwhite skipnl nextgroup=shCaseBar	contained
endif
syn region  shCaseSingleQuote	matchgroup=shQuote start=+'+ end=+'+		contains=shStringSpecial		skipwhite skipnl nextgroup=shCaseBar	contained
syn region  shCaseDoubleQuote	matchgroup=shQuote start=+"+ skip=+\\\\\|\\.+ end=+"+	contains=@shDblQuoteList,shStringSpecial	skipwhite skipnl nextgroup=shCaseBar	contained
syn region  shCaseCommandSub	start=+`+ skip=+\\\\\|\\.+ end=+`+		contains=@shCommandSubList		skipwhite skipnl nextgroup=shCaseBar	contained
if exists("b:is_bash")
 syn region  shCaseRange	matchgroup=Delimiter start=+\[+ skip=+\\\\+ end=+\]+	contained	contains=shCharClass
 syn match   shCharClass	'\[:\%(alnum\|alpha\|ascii\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|word\|or\|xdigit\):\]'			contained
else
 syn region  shCaseRange	matchgroup=Delimiter start=+\[+ skip=+\\\\+ end=+\]+	contained
endif
" Misc: {{{1
"======
syn match   shWrapLineOperator "\\$"
syn region  shCommandSub   start="`" skip="\\\\\|\\." end="`"	contains=@shCommandSubList
syn match   shEscape	contained	'\%(^\)\@!\%(\\\\\)*\\.'

" $() and $(()): {{{1
" $(..) is not supported by sh (Bourne shell).  However, apparently
" some systems (HP?) have as their /bin/sh a (link to) Korn shell
" (ie. Posix compliant shell).  /bin/ksh should work for those
" systems too, however, so the following syntax will flag $(..) as
" an Error under /bin/sh.  By consensus of vimdev'ers!
if exists("b:is_kornshell") || exists("b:is_bash") || exists("b:is_posix")
 syn region shCommandSub matchgroup=shCmdSubRegion start="\$("  skip='\\\\\|\\.' end=")"  contains=@shCommandSubList
 syn region shArithmetic matchgroup=shArithRegion  start="\$((" skip='\\\\\|\\.' end="))" contains=@shArithList
 syn region shArithmetic matchgroup=shArithRegion  start="\$\[" skip='\\\\\|\\.' end="\]" contains=@shArithList
 syn match  shSkipInitWS contained	"^\s\+"
elseif !exists("g:sh_no_error")
 syn region shCommandSub matchgroup=Error start="\$(" end=")" contains=@shCommandSubList
endif
syn region shCmdParenRegion matchgroup=shCmdSubRegion start="(\ze[^(]" skip='\\\\\|\\.' end=")" contains=@shCommandSubList

if exists("b:is_bash")
 syn cluster shCommandSubList add=bashSpecialVariables,bashStatement
 syn cluster shCaseList add=bashAdminStatement,bashStatement
 syn keyword bashSpecialVariables contained auto_resume BASH BASH_ALIASES BASH_ALIASES BASH_ARGC BASH_ARGC BASH_ARGV BASH_ARGV BASH_CMDS BASH_CMDS BASH_COMMAND BASH_COMMAND BASH_ENV BASH_EXECUTION_STRING BASH_EXECUTION_STRING BASH_LINENO BASH_LINENO BASHOPTS BASHOPTS BASHPID BASHPID BASH_REMATCH BASH_REMATCH BASH_SOURCE BASH_SOURCE BASH_SUBSHELL BASH_SUBSHELL BASH_VERSINFO BASH_VERSION BASH_XTRACEFD BASH_XTRACEFD CDPATH COLUMNS COLUMNS COMP_CWORD COMP_CWORD COMP_KEY COMP_KEY COMP_LINE COMP_LINE COMP_POINT COMP_POINT COMPREPLY COMPREPLY COMP_TYPE COMP_TYPE COMP_WORDBREAKS COMP_WORDBREAKS COMP_WORDS COMP_WORDS COPROC COPROC DIRSTACK EMACS EMACS ENV ENV EUID FCEDIT FIGNORE FUNCNAME FUNCNAME FUNCNEST FUNCNEST GLOBIGNORE GROUPS histchars HISTCMD HISTCONTROL HISTFILE HISTFILESIZE HISTIGNORE HISTSIZE HISTTIMEFORMAT HISTTIMEFORMAT HOME HOSTFILE HOSTNAME HOSTTYPE IFS IGNOREEOF INPUTRC LANG LC_ALL LC_COLLATE LC_CTYPE LC_CTYPE LC_MESSAGES LC_NUMERIC LC_NUMERIC LINENO LINES LINES MACHTYPE MAIL MAILCHECK MAILPATH MAPFILE MAPFILE OLDPWD OPTARG OPTERR OPTIND OSTYPE PATH PIPESTATUS POSIXLY_CORRECT POSIXLY_CORRECT PPID PROMPT_COMMAND PS1 PS2 PS3 PS4 PWD RANDOM READLINE_LINE READLINE_LINE READLINE_POINT READLINE_POINT REPLY SECONDS SHELL SHELL SHELLOPTS SHLVL TIMEFORMAT TIMEOUT TMPDIR TMPDIR UID
 syn keyword bashStatement chmod clear complete du egrep expr fgrep find gnufind gnugrep grep less ls mkdir mv rm rmdir rpm sed sleep sort strip tail
 syn keyword bashAdminStatement daemon killall killproc nice reload restart start status stop
 syn keyword bashStatement	command compgen
endif

if exists("b:is_kornshell")
 syn cluster shCommandSubList add=kshSpecialVariables,kshStatement
 syn cluster shCaseList add=kshStatement
 syn keyword kshSpecialVariables contained CDPATH COLUMNS EDITOR ENV ERRNO FCEDIT FPATH HISTFILE HISTSIZE HOME IFS LINENO LINES MAIL MAILCHECK MAILPATH OLDPWD OPTARG OPTIND PATH PPID PS1 PS2 PS3 PS4 PWD RANDOM REPLY SECONDS SHELL TMOUT VISUAL
 syn keyword kshStatement cat chmod clear cp du egrep expr fgrep find grep killall less ls mkdir mv nice printenv rm rmdir sed sort strip stty tail tput
 syn keyword kshStatement command setgroups setsenv
endif

syn match   shSource	"^\.\s"
syn match   shSource	"\s\.\s"
"syn region  shColon	start="^\s*:" end="$" end="\s#"me=e-2 contains=@shColonList
"syn region  shColon	start="^\s*\zs:" end="$" end="\s#"me=e-2
if exists("b:is_kornshell")
 syn match   shColon	'^\s*\zs:'
endif

" String And Character Constants: {{{1
"================================
syn match   shNumber	"\<\d\+\>#\="
syn match   shNumber	"\<-\=\.\=\d\+\>#\="
syn match   shCtrlSeq	"\\\d\d\d\|\\[abcfnrtv0]"			contained
if exists("b:is_bash")
 syn match   shSpecial	"[^\\]\(\\\\\)*\zs\\\o\o\o\|\\x\x\x\|\\c[^"]\|\\[abefnrtv]"	contained
 syn match   shSpecial	"^\(\\\\\)*\zs\\\o\o\o\|\\x\x\x\|\\c[^"]\|\\[abefnrtv]"	contained
endif
if exists("b:is_bash")
 syn region  shExSingleQuote	matchgroup=shQuote start=+\$'+ skip=+\\\\\|\\.+ end=+'+	contains=shStringSpecial,shSpecial		nextgroup=shSpecialNxt
 syn region  shExDoubleQuote	matchgroup=shQuote start=+\$"+ skip=+\\\\\|\\.\|\\"+ end=+"+	contains=@shDblQuoteList,shStringSpecial,shSpecial	nextgroup=shSpecialNxt
elseif !exists("g:sh_no_error")
 syn region  shExSingleQuote	matchGroup=Error start=+\$'+ skip=+\\\\\|\\.+ end=+'+	contains=shStringSpecial
 syn region  shExDoubleQuote	matchGroup=Error start=+\$"+ skip=+\\\\\|\\.+ end=+"+	contains=shStringSpecial
endif
syn region  shSingleQuote	matchgroup=shQuote start=+'+ end=+'+		contains=@Spell
syn region  shDoubleQuote	matchgroup=shQuote start=+\%(\%(\\\\\)*\\\)\@<!"+ skip=+\\"+ end=+"+	contains=@shDblQuoteList,shStringSpecial,@Spell
syn match   shStringSpecial	"[^[:print:] \t]"			contained
syn match   shStringSpecial	"[^\\]\zs\%(\\\\\)*\\[\\"'`$()#]"
syn match   shSpecial	"[^\\]\zs\%(\\\\\)*\\[\\"'`$()#]"		nextgroup=shBkslshSnglQuote,shBkslshDblQuote,@shNoZSList
syn match   shSpecial	"^\%(\\\\\)*\\[\\"'`$()#]"
syn match   shSpecialNoZS	contained	"\%(\\\\\)*\\[\\"'`$()#]"
syn match   shSpecialNxt	contained	"\\[\\"'`$()#]"
syn region  shBkslshSnglQuote	contained	matchgroup=shQuote start=+'+ end=+'+	contains=@Spell
syn region  shBkslshDblQuote	contained	matchgroup=shQuote start=+"+ skip=+\\"+ end=+"+	contains=@shDblQuoteList,shStringSpecial,@Spell

" Comments: {{{1
"==========
syn cluster	shCommentGroup	contains=shTodo,@Spell
if exists("b:is_bash")
 syn match	shTodo	contained		"\<\%(COMBAK\|FIXME\|TODO\|XXX\|NOTE\)\ze:\=\>"
else
 syn keyword	shTodo	contained		COMBAK FIXME TODO XXX NOTE
endif
syn match	shComment		"^\s*\zs#.*$"	contains=@shCommentGroup
syn match	shComment		"\s\zs#.*$"	contains=@shCommentGroup
syn match	shComment	contained	"#.*$"	contains=@shCommentGroup
syn match	shQuickComment	contained	"#.*$"

" Here Documents: {{{1
" =========================================
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc01 start="<<\s*\\\=\z([^ \t|>]\+\)"		matchgroup=shHereDoc01 end="^\z1\s*$"	contains=@shDblQuoteList
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc02 start="<<\s*\"\z([^ \t|>]\+\)\""		matchgroup=shHereDoc02 end="^\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc03 start="<<-\s*\z([^ \t|>]\+\)"		matchgroup=shHereDoc03 end="^\s*\z1\s*$"	contains=@shDblQuoteList
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc04 start="<<-\s*'\z([^']\+\)'"		matchgroup=shHereDoc04 end="^\s*\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc05 start="<<\s*'\z([^']\+\)'"		matchgroup=shHereDoc05 end="^\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc06 start="<<-\s*\"\z([^ \t|>]\+\)\""		matchgroup=shHereDoc06 end="^\s*\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc07 start="<<\s*\\\_$\_s*\z([^ \t|>]\+\)"		matchgroup=shHereDoc07 end="^\z1\s*$"           contains=@shDblQuoteList
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc08 start="<<\s*\\\_$\_s*'\z([^ \t|>]\+\)'"	matchgroup=shHereDoc08 end="^\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc09 start="<<\s*\\\_$\_s*\"\z([^ \t|>]\+\)\""	matchgroup=shHereDoc09 end="^\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc10 start="<<-\s*\\\_$\_s*\z([^ \t|>]\+\)"	matchgroup=shHereDoc10 end="^\s*\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc11 start="<<-\s*\\\_$\_s*\\\z([^ \t|>]\+\)"	matchgroup=shHereDoc11 end="^\s*\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc12 start="<<-\s*\\\_$\_s*'\z([^ \t|>]\+\)'"	matchgroup=shHereDoc12 end="^\s*\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc13 start="<<-\s*\\\_$\_s*\"\z([^ \t|>]\+\)\""	matchgroup=shHereDoc13 end="^\s*\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc14 start="<<\\\z([^ \t|>]\+\)"		matchgroup=shHereDoc14 end="^\z1\s*$"
ShFoldHereDoc syn region shHereDoc matchgroup=shHereDoc15 start="<<-\s*\\\z([^ \t|>]\+\)"		matchgroup=shHereDoc15 end="^\s*\z1\s*$"

" Here Strings: {{{1
" =============
" available for: bash; ksh (really should be ksh93 only) but not if its a posix
if exists("b:is_bash") || (exists("b:is_kornshell") && !exists("b:is_posix"))
 syn match shHereString "<<<"	skipwhite	nextgroup=shCmdParenRegion
endif

" Identifiers: {{{1
"=============
syn match  shSetOption	"\s\zs[-+][a-zA-Z0-9]\+\>"	contained
syn match  shVariable	"\<\([bwglsav]:\)\=[a-zA-Z0-9.!@_%,]*\ze\(=\|[-+]=\)"	nextgroup=shVarAssign
syn match  shVarAssign	"\(=\|[-+]=\)"		contained	nextgroup=shCmdParenRegion,shPattern,shDeref,shDerefSimple,shDoubleQuote,shExDoubleQuote,shSingleQuote,shExSingleQuote
syn region shAtExpr	contained	start="@(" end=")" contains=@shIdList
if exists("b:is_bash")
 syn region shSetList oneline matchgroup=shSet start="\<\(declare\|typeset\|local\|export\|unset\)\>\ze[^/]" end="$"	matchgroup=shSetListDelim end="\ze[}|);&]" matchgroup=NONE end="\ze\s\+#\|="	contains=@shIdList
 syn region shSetList oneline matchgroup=shSet start="\<set\>\ze[^/]" end="\ze[;|)]\|$"			matchgroup=shSetListDelim end="\ze[}|);&]" matchgroup=NONE end="\ze\s\+="	contains=@shIdList
elseif exists("b:is_kornshell")
 syn region shSetList oneline matchgroup=shSet start="\<\(typeset\|export\|unset\)\>\ze[^/]" end="$"		matchgroup=shSetListDelim end="\ze[}|);&]" matchgroup=NONE end="\ze\s\+[#=]"	contains=@shIdList
 syn region shSetList oneline matchgroup=shSet start="\<set\>\ze[^/]" end="$"				matchgroup=shSetListDelim end="\ze[}|);&]" matchgroup=NONE end="\ze\s\+[#=]"	contains=@shIdList
else
 syn region shSetList oneline matchgroup=shSet start="\<\(set\|export\|unset\)\>\ze[^/]" end="$"		matchgroup=shSetListDelim end="\ze[}|);&]" matchgroup=NONE end="\ze\s\+[#=]"	contains=@shIdList
endif

" Functions: {{{1
if !exists("b:is_posix")
 syn keyword shFunctionKey function	skipwhite skipnl nextgroup=shFunctionTwo
endif

if exists("b:is_bash")
 ShFoldFunctions syn region shFunctionOne	matchgroup=shFunction start="^\s*[A-Za-z_0-9:][-a-zA-Z_0-9:]*\s*()\_s*{"		end="}"	contains=@shFunctionList		 skipwhite skipnl nextgroup=shFunctionStart,shQuickComment
 ShFoldFunctions syn region shFunctionTwo	matchgroup=shFunction start="\%(do\)\@!\&\<[A-Za-z_0-9:][-a-zA-Z_0-9:]*\>\s*\%(()\)\=\_s*{"	end="}"	contains=shFunctionKey,@shFunctionList contained skipwhite skipnl nextgroup=shFunctionStart,shQuickComment
 ShFoldFunctions syn region shFunctionThree	matchgroup=shFunction start="^\s*[A-Za-z_0-9:][-a-zA-Z_0-9:]*\s*()\_s*("		end=")"	contains=@shFunctionList		 skipwhite skipnl nextgroup=shFunctionStart,shQuickComment
 ShFoldFunctions syn region shFunctionFour	matchgroup=shFunction start="\%(do\)\@!\&\<[A-Za-z_0-9:][-a-zA-Z_0-9:]*\>\s*\%(()\)\=\_s*)"	end=")"	contains=shFunctionKey,@shFunctionList contained skipwhite skipnl nextgroup=shFunctionStart,shQuickComment
else
 ShFoldFunctions syn region shFunctionOne	matchgroup=shFunction start="^\s*\h\w*\s*()\_s*{"			end="}"	contains=@shFunctionList		 skipwhite skipnl nextgroup=shFunctionStart,shQuickComment
 ShFoldFunctions syn region shFunctionTwo	matchgroup=shFunction start="\%(do\)\@!\&\<\h\w*\>\s*\%(()\)\=\_s*{"		end="}"	contains=shFunctionKey,@shFunctionList contained skipwhite skipnl nextgroup=shFunctionStart,shQuickComment
 ShFoldFunctions syn region shFunctionThree	matchgroup=shFunction start="^\s*\h\w*\s*()\_s*("			end=")"	contains=@shFunctionList		 skipwhite skipnl nextgroup=shFunctionStart,shQuickComment
 ShFoldFunctions syn region shFunctionFour	matchgroup=shFunction start="\%(do\)\@!\&\<\h\w*\>\s*\%(()\)\=\_s*("		end=")"	contains=shFunctionKey,@shFunctionList contained skipwhite skipnl nextgroup=shFunctionStart,shQuickComment
endif

" Parameter Dereferencing: {{{1
" ========================
if !exists("g:sh_no_error")
 "syn match  shDerefWordError	"[^}$[~]"	contained
endif
syn match  shDerefSimple	"\$\%(\h\w*\|\d\)"	nextgroup=@shNoZSList
syn region shDeref	matchgroup=PreProc start="\${" end="}"	contains=@shDerefList,shDerefVarArray
syn match  shDerefSimple	"\$[-#*@!?]"	nextgroup=@shNoZSList
syn match  shDerefSimple	"\$\$"	nextgroup=@shNoZSList
syn match  shDerefSimple	"\${\d}"	nextgroup=@shNoZSList
if exists("b:is_bash") || exists("b:is_kornshell")
 syn region shDeref	matchgroup=PreProc start="\${##\=" end="}"	contains=@shDerefList	nextgroup=@shSpecialNoZS
 syn region shDeref	matchgroup=PreProc start="\${\$\$" end="}"	contains=@shDerefList	nextgroup=@shSpecialNoZS
endif

" ksh: ${!var[*]} array index list syntax: {{{1
" ========================================
if exists("b:is_kornshell")
 syn region shDeref	matchgroup=PreProc start="\${!" end="}"	contains=@shDerefVarArray
endif

" bash: ${!prefix*} and ${#parameter}: {{{1
" ====================================
if exists("b:is_bash")
 syn region shDeref	matchgroup=PreProc start="\${!" end="\*\=}"	contains=@shDerefList,shDerefOff
 syn match  shDerefVar	contained	"{\@<=!\h\w*"		nextgroup=@shDerefVarList
endif
if exists("b:is_kornshell")
 syn match  shDerefVar	contained	"{\@<=!\h\w*[[:alnum:]_.]*"	nextgroup=@shDerefVarList
endif

syn match  shDerefSpecial	contained	"{\@<=[-*@?0]"		nextgroup=shDerefOp,shDerefOpError
syn match  shDerefSpecial	contained	"\({[#!]\)\@<=[[:alnum:]*@_]\+"	nextgroup=@shDerefVarList,shDerefOp
syn match  shDerefVar	contained	"{\@<=\h\w*"		nextgroup=@shDerefVarList
syn match  shDerefVar	contained	'\d'                            nextgroup=@shDerefVarList
if exists("b:is_kornshell")
  syn match  shDerefVar	contained	"{\@<=\h\w*[[:alnum:]_.]*"	nextgroup=@shDerefVarList
endif

" sh ksh bash : ${var[... ]...}  array reference: {{{1
syn region  shDerefVarArray   contained	matchgroup=shDeref start="\[" end="]"	contains=@shCommandSubList nextgroup=shDerefOp,shDerefOpError

" Special ${parameter OPERATOR word} handling: {{{1
" sh ksh bash : ${parameter:-word}    word is default value
" sh ksh bash : ${parameter:=word}    assign word as default value
" sh ksh bash : ${parameter:?word}    display word if parameter is null
" sh ksh bash : ${parameter:+word}    use word if parameter is not null, otherwise nothing
"    ksh bash : ${parameter#pattern}  remove small left  pattern
"    ksh bash : ${parameter##pattern} remove large left  pattern
"    ksh bash : ${parameter%pattern}  remove small right pattern
"    ksh bash : ${parameter%%pattern} remove large right pattern
"        bash : ${parameter^pattern}  Case modification
"        bash : ${parameter^^pattern} Case modification
"        bash : ${parameter,pattern}  Case modification
"        bash : ${parameter,,pattern} Case modification
syn cluster shDerefPatternList	contains=shDerefPattern,shDerefString
if !exists("g:sh_no_error")
 "syn match shDerefOpError	contained	":[[:punct:]]"
endif
syn match  shDerefOp	contained	":\=[-=?]"		nextgroup=@shDerefPatternList
syn match  shDerefOp	contained	":\=+"		nextgroup=@shDerefPatternList
if exists("b:is_bash") || exists("b:is_kornshell")
 syn match  shDerefOp	contained	"#\{1,2}"		nextgroup=@shDerefPatternList
 syn match  shDerefOp	contained	"%\{1,2}"		nextgroup=@shDerefPatternList
 syn match  shDerefPattern	contained	"[^{}]\+"		contains=shDeref,shDerefSimple,shDerefPattern,shDerefString,shCommandSub,shDerefEscape nextgroup=shDerefPattern
 syn region shDerefPattern	contained	start="{" end="}"	contains=shDeref,shDerefSimple,shDerefString,shCommandSub nextgroup=shDerefPattern
 syn match  shDerefEscape	contained	'\%(\\\\\)*\\.'
endif
if exists("b:is_bash")
 syn match  shDerefOp	contained	"[,^]\{1,2}"		nextgroup=@shDerefPatternList
endif
syn region shDerefString	contained	matchgroup=shDerefDelim start=+\%(\\\)\@<!'+ end=+'+	contains=shStringSpecial
syn region shDerefString	contained	matchgroup=shDerefDelim start=+\%(\\\)\@<!"+ skip=+\\"+ end=+"+	contains=@shDblQuoteList,shStringSpecial
syn match  shDerefString	contained	"\\["']"		nextgroup=shDerefPattern

if exists("b:is_bash")
 " bash : ${parameter:offset}
 " bash : ${parameter:offset:length}
 syn region shDerefOff	contained	start=':'	end='\ze:'	end='\ze}'	contains=shDeref,shDerefSimple,shDerefEscape	nextgroup=shDerefLen,shDeref,shDerefSimple
 syn region shDerefOff	contained	start=':\s-'	end='\ze:'	end='\ze}'	contains=shDeref,shDerefSimple,shDerefEscape	nextgroup=shDerefLen,shDeref,shDerefSimple
 syn match  shDerefLen	contained	":[^}]\+"	contains=shDeref,shDerefSimple

 " bash : ${parameter//pattern/string}
 " bash : ${parameter//pattern}
 syn match  shDerefPPS	contained	'/\{1,2}'	nextgroup=shDerefPPSleft
 syn region shDerefPPSleft	contained	start='.'	skip=@\%(\\\\\)*\\/@ matchgroup=shDerefOp	end='/' end='\ze}' nextgroup=shDerefPPSright contains=@shCommandSubList
 syn region shDerefPPSright	contained	start='.'	skip=@\%(\\\\\)\+@		end='\ze}'	contains=@shPPSRightList

 " bash : ${parameter/#substring/replacement}
 syn match  shDerefPSR	contained	'/#'	nextgroup=shDerefPSRleft
 syn region shDerefPSRleft	contained	start='.'	skip=@\%(\\\\\)*\\/@ matchgroup=shDerefOp	end='/' end='\ze}' nextgroup=shDerefPSRright
 syn region shDerefPSRright	contained	start='.'	skip=@\%(\\\\\)\+@		end='\ze}'
endif

" Arithmetic Parenthesized Expressions: {{{1
"syn region shParen matchgroup=shArithRegion start='[^$]\zs(\%(\ze[^(]\|$\)' end=')' contains=@shArithParenList
syn region shParen matchgroup=shArithRegion start='\$\@!(\%(\ze[^(]\|$\)' end=')' contains=@shArithParenList

" Useful sh Keywords: {{{1
" ===================
syn keyword shStatement break cd chdir continue eval exec exit kill newgrp pwd read readonly return shift test trap ulimit umask wait
syn keyword shConditional contained elif else then
if !exists("g:sh_no_error")
 syn keyword shCondError elif else then
endif

" Useful ksh Keywords: {{{1
" ====================
if exists("b:is_kornshell") || exists("b:is_bash")
 syn keyword shStatement autoload bg false fc fg functions getopts hash history integer jobs let nohup printf r stop suspend times true type unalias whence
 if exists("b:is_posix")
  syn keyword shStatement command
 else
  syn keyword shStatement time
 endif

" Useful bash Keywords: {{{1
" =====================
 if exists("b:is_bash")
  syn keyword shStatement bind builtin dirs disown enable help logout popd pushd shopt source
 else
  syn keyword shStatement login newgrp
 endif
endif


" =======================================================================================

" MODIFICATIONS: {{{1
" =====================
syn match   zshOptStart /^\s*\%(\%(\%(un\)\?setopt\)\|set\s+[-+]o\)/ nextgroup=zshOption skipwhite
syn match   zshOption /
	\ \%(\%(\<no_\?\)\?aliases\>\)\|
	\ \%(\%(\<no_\?\)\?allexport\>\)\|\%(\%(no_\?\)\?all_export\>\)\|
	\ \%(\%(\<no_\?\)\?alwayslastprompt\>\)\|\%(\%(no_\?\)\?always_last_prompt\>\)\|\%(\%(no_\?\)\?always_lastprompt\>\)\|
	\ \%(\%(\<no_\?\)\?alwaystoend\>\)\|\%(\%(no_\?\)\?always_to_end\>\)\|
	\ \%(\%(\<no_\?\)\?appendcreate\>\)\|\%(\%(no_\?\)\?append_create\>\)\|
	\ \%(\%(\<no_\?\)\?appendhistory\>\)\|\%(\%(no_\?\)\?append_history\>\)\|
	\ \%(\%(\<no_\?\)\?autocd\>\)\|\%(\%(no_\?\)\?auto_cd\>\)\|
	\ \%(\%(\<no_\?\)\?autocontinue\>\)\|\%(\%(no_\?\)\?auto_continue\>\)\|
	\ \%(\%(\<no_\?\)\?autolist\>\)\|\%(\%(no_\?\)\?auto_list\>\)\|
	\ \%(\%(\<no_\?\)\?automenu\>\)\|\%(\%(no_\?\)\?auto_menu\>\)\|
	\ \%(\%(\<no_\?\)\?autonamedirs\>\)\|\%(\%(no_\?\)\?auto_name_dirs\>\)\|
	\ \%(\%(\<no_\?\)\?autoparamkeys\>\)\|\%(\%(no_\?\)\?auto_param_keys\>\)\|
	\ \%(\%(\<no_\?\)\?autoparamslash\>\)\|\%(\%(no_\?\)\?auto_param_slash\>\)\|
	\ \%(\%(\<no_\?\)\?autopushd\>\)\|\%(\%(no_\?\)\?auto_pushd\>\)\|
	\ \%(\%(\<no_\?\)\?autoremoveslash\>\)\|\%(\%(no_\?\)\?auto_remove_slash\>\)\|
	\ \%(\%(\<no_\?\)\?autoresume\>\)\|\%(\%(no_\?\)\?auto_resume\>\)\|
	\ \%(\%(\<no_\?\)\?badpattern\>\)\|\%(\%(no_\?\)\?bad_pattern\>\)\|
	\ \%(\%(\<no_\?\)\?banghist\>\)\|\%(\%(no_\?\)\?bang_hist\>\)\|
	\ \%(\%(\<no_\?\)\?bareglobqual\>\)\|\%(\%(no_\?\)\?bare_glob_qual\>\)\|
	\ \%(\%(\<no_\?\)\?bashautolist\>\)\|\%(\%(no_\?\)\?bash_auto_list\>\)\|
	\ \%(\%(\<no_\?\)\?bashrematch\>\)\|\%(\%(no_\?\)\?bash_rematch\>\)\|
	\ \%(\%(\<no_\?\)\?beep\>\)\|
	\ \%(\%(\<no_\?\)\?bgnice\>\)\|\%(\%(no_\?\)\?bg_nice\>\)\|
	\ \%(\%(\<no_\?\)\?braceccl\>\)\|\%(\%(no_\?\)\?brace_ccl\>\)\|
	\ \%(\%(\<no_\?\)\?braceexpand\>\)\|\%(\%(no_\?\)\?brace_expand\>\)\|
	\ \%(\%(\<no_\?\)\?bsdecho\>\)\|\%(\%(no_\?\)\?bsd_echo\>\)\|
	\ \%(\%(\<no_\?\)\?caseglob\>\)\|\%(\%(no_\?\)\?case_glob\>\)\|
	\ \%(\%(\<no_\?\)\?casematch\>\)\|\%(\%(no_\?\)\?case_match\>\)\|
	\ \%(\%(\<no_\?\)\?cbases\>\)\|\%(\%(no_\?\)\?c_bases\>\)\|
	\ \%(\%(\<no_\?\)\?cdablevars\>\)\|\%(\%(no_\?\)\?cdable_vars\>\)\|\%(\%(no_\?\)\?cd_able_vars\>\)\|
	\ \%(\%(\<no_\?\)\?chasedots\>\)\|\%(\%(no_\?\)\?chase_dots\>\)\|
	\ \%(\%(\<no_\?\)\?chaselinks\>\)\|\%(\%(no_\?\)\?chase_links\>\)\|
	\ \%(\%(\<no_\?\)\?checkjobs\>\)\|\%(\%(no_\?\)\?check_jobs\>\)\|
	\ \%(\%(\<no_\?\)\?clobber\>\)\|
	\ \%(\%(\<no_\?\)\?combiningchars\>\)\|\%(\%(no_\?\)\?combining_chars\>\)\|
	\ \%(\%(\<no_\?\)\?completealiases\>\)\|\%(\%(no_\?\)\?complete_aliases\>\)\|
	\ \%(\%(\<no_\?\)\?completeinword\>\)\|\%(\%(no_\?\)\?complete_in_word\>\)\|
	\ \%(\%(\<no_\?\)\?continueonerror\>\)\|\%(\%(no_\?\)\?continue_on_error\>\)\|
	\ \%(\%(\<no_\?\)\?correct\>\)\|
	\ \%(\%(\<no_\?\)\?correctall\>\)\|\%(\%(no_\?\)\?correct_all\>\)\|
	\ \%(\%(\<no_\?\)\?cprecedences\>\)\|\%(\%(no_\?\)\?c_precedences\>\)\|
	\ \%(\%(\<no_\?\)\?cshjunkiehistory\>\)\|\%(\%(no_\?\)\?csh_junkie_history\>\)\|
	\ \%(\%(\<no_\?\)\?cshjunkieloops\>\)\|\%(\%(no_\?\)\?csh_junkie_loops\>\)\|
	\ \%(\%(\<no_\?\)\?cshjunkiequotes\>\)\|\%(\%(no_\?\)\?csh_junkie_quotes\>\)\|
	\ \%(\%(\<no_\?\)\?csh_nullcmd\>\)\|\%(\%(no_\?\)\?csh_null_cmd\>\)\|\%(\%(no_\?\)\?cshnullcmd\>\)\|\%(\%(no_\?\)\?csh_null_cmd\>\)\|
	\ \%(\%(\<no_\?\)\?cshnullglob\>\)\|\%(\%(no_\?\)\?csh_null_glob\>\)\|
	\ \%(\%(\<no_\?\)\?debugbeforecmd\>\)\|\%(\%(no_\?\)\?debug_before_cmd\>\)\|
	\ \%(\%(\<no_\?\)\?dotglob\>\)\|\%(\%(no_\?\)\?dot_glob\>\)\|
	\ \%(\%(\<no_\?\)\?dvorak\>\)\|
	\ \%(\%(\<no_\?\)\?emacs\>\)\|
	\ \%(\%(\<no_\?\)\?equals\>\)\|
	\ \%(\%(\<no_\?\)\?errexit\>\)\|\%(\%(no_\?\)\?err_exit\>\)\|
	\ \%(\%(\<no_\?\)\?errreturn\>\)\|\%(\%(no_\?\)\?err_return\>\)\|
	\ \%(\%(\<no_\?\)\?evallineno_\?\)\|\%(\%(no_\?\)\?eval_lineno_\?\)\|
	\ \%(\%(\<no_\?\)\?exec\>\)\|
	\ \%(\%(\<no_\?\)\?extendedglob\>\)\|\%(\%(no_\?\)\?extended_glob\>\)\|
	\ \%(\%(\<no_\?\)\?extendedhistory\>\)\|\%(\%(no_\?\)\?extended_history\>\)\|
	\ \%(\%(\<no_\?\)\?flowcontrol\>\)\|\%(\%(no_\?\)\?flow_control\>\)\|
	\ \%(\%(\<no_\?\)\?forcefloat\>\)\|\%(\%(no_\?\)\?force_float\>\)\|
	\ \%(\%(\<no_\?\)\?functionargzero\>\)\|\%(\%(no_\?\)\?function_argzero\>\)\|\%(\%(no_\?\)\?function_arg_zero\>\)\|
	\ \%(\%(\<no_\?\)\?glob\>\)\|
	\ \%(\%(\<no_\?\)\?globalexport\>\)\|\%(\%(no_\?\)\?global_export\>\)\|
	\ \%(\%(\<no_\?\)\?globalrcs\>\)\|\%(\%(no_\?\)\?global_rcs\>\)\|
	\ \%(\%(\<no_\?\)\?globassign\>\)\|\%(\%(no_\?\)\?glob_assign\>\)\|
	\ \%(\%(\<no_\?\)\?globcomplete\>\)\|\%(\%(no_\?\)\?glob_complete\>\)\|
	\ \%(\%(\<no_\?\)\?globdots\>\)\|\%(\%(no_\?\)\?glob_dots\>\)\|
	\ \%(\%(\<no_\?\)\?glob_subst\>\)\|\%(\%(no_\?\)\?globsubst\>\)\|
	\ \%(\%(\<no_\?\)\?globstarshort\>\)\|\%(\%(no_\?\)\?glob_star_short\>\)\|
	\ \%(\%(\<no_\?\)\?hashall\>\)\|\%(\%(no_\?\)\?hash_all\>\)\|
	\ \%(\%(\<no_\?\)\?hashcmds\>\)\|\%(\%(no_\?\)\?hash_cmds\>\)\|
	\ \%(\%(\<no_\?\)\?hashdirs\>\)\|\%(\%(no_\?\)\?hash_dirs\>\)\|
	\ \%(\%(\<no_\?\)\?hashexecutablesonly\>\)\|\%(\%(no_\?\)\?hash_executables_only\>\)\|
	\ \%(\%(\<no_\?\)\?hashlistall\>\)\|\%(\%(no_\?\)\?hash_list_all\>\)\|
	\ \%(\%(\<no_\?\)\?histallowclobber\>\)\|\%(\%(no_\?\)\?hist_allow_clobber\>\)\|
	\ \%(\%(\<no_\?\)\?histappend\>\)\|\%(\%(no_\?\)\?hist_append\>\)\|
	\ \%(\%(\<no_\?\)\?histbeep\>\)\|\%(\%(no_\?\)\?hist_beep\>\)\|
	\ \%(\%(\<no_\?\)\?hist_expand\>\)\|\%(\%(no_\?\)\?histexpand\>\)\|
	\ \%(\%(\<no_\?\)\?hist_expire_dups_first\>\)\|\%(\%(no_\?\)\?histexpiredupsfirst\>\)\|
	\ \%(\%(\<no_\?\)\?histfcntllock\>\)\|\%(\%(no_\?\)\?hist_fcntl_lock\>\)\|
	\ \%(\%(\<no_\?\)\?histfindnodups\>\)\|\%(\%(no_\?\)\?hist_find_no_dups\>\)\|
	\ \%(\%(\<no_\?\)\?histignorealldups\>\)\|\%(\%(no_\?\)\?hist_ignore_all_dups\>\)\|
	\ \%(\%(\<no_\?\)\?histignoredups\>\)\|\%(\%(no_\?\)\?hist_ignore_dups\>\)\|
	\ \%(\%(\<no_\?\)\?histignorespace\>\)\|\%(\%(no_\?\)\?hist_ignore_space\>\)\|
	\ \%(\%(\<no_\?\)\?histlexwords\>\)\|\%(\%(no_\?\)\?hist_lex_words\>\)\|
	\ \%(\%(\<no_\?\)\?histnofunctions\>\)\|\%(\%(no_\?\)\?hist_no_functions\>\)\|
	\ \%(\%(\<no_\?\)\?histnostore\>\)\|\%(\%(no_\?\)\?hist_no_store\>\)\|
	\ \%(\%(\<no_\?\)\?histreduceblanks\>\)\|\%(\%(no_\?\)\?hist_reduce_blanks\>\)\|
	\ \%(\%(\<no_\?\)\?histsavebycopy\>\)\|\%(\%(no_\?\)\?hist_save_by_copy\>\)\|
	\ \%(\%(\<no_\?\)\?histsavenodups\>\)\|\%(\%(no_\?\)\?hist_save_no_dups\>\)\|
	\ \%(\%(\<no_\?\)\?histsubstpattern\>\)\|\%(\%(no_\?\)\?hist_subst_pattern\>\)\|
	\ \%(\%(\<no_\?\)\?histverify\>\)\|\%(\%(no_\?\)\?hist_verify\>\)\|
	\ \%(\%(\<no_\?\)\?hup\>\)\|
	\ \%(\%(\<no_\?\)\?ignorebraces\>\)\|\%(\%(no_\?\)\?ignore_braces\>\)\|
	\ \%(\%(\<no_\?\)\?ignoreclosebraces\>\)\|\%(\%(no_\?\)\?ignore_close_braces\>\)\|
	\ \%(\%(\<no_\?\)\?ignoreeof\>\)\|\%(\%(no_\?\)\?ignore_eof\>\)\|
	\ \%(\%(\<no_\?\)\?incappendhistory\>\)\|\%(\%(no_\?\)\?inc_append_history\>\)\|
	\ \%(\%(\<no_\?\)\?incappendhistorytime\>\)\|\%(\%(no_\?\)\?inc_append_history_time\>\)\|
	\ \%(\%(\<no_\?\)\?interactive\>\)\|
	\ \%(\%(\<no_\?\)\?interactivecomments\>\)\|\%(\%(no_\?\)\?interactive_comments\>\)\|
	\ \%(\%(\<no_\?\)\?ksharrays\>\)\|\%(\%(no_\?\)\?ksh_arrays\>\)\|
	\ \%(\%(\<no_\?\)\?kshautoload\>\)\|\%(\%(no_\?\)\?ksh_autoload\>\)\|
	\ \%(\%(\<no_\?\)\?kshglob\>\)\|\%(\%(no_\?\)\?ksh_glob\>\)\|
	\ \%(\%(\<no_\?\)\?kshoptionprint\>\)\|\%(\%(no_\?\)\?ksh_option_print\>\)\|
	\ \%(\%(\<no_\?\)\?kshtypeset\>\)\|\%(\%(no_\?\)\?ksh_typeset\>\)\|
	\ \%(\%(\<no_\?\)\?kshzerosubscript\>\)\|\%(\%(no_\?\)\?ksh_zero_subscript\>\)\|
	\ \%(\%(\<no_\?\)\?listambiguous\>\)\|\%(\%(no_\?\)\?list_ambiguous\>\)\|
	\ \%(\%(\<no_\?\)\?listbeep\>\)\|\%(\%(no_\?\)\?list_beep\>\)\|
	\ \%(\%(\<no_\?\)\?listpacked\>\)\|\%(\%(no_\?\)\?list_packed\>\)\|
	\ \%(\%(\<no_\?\)\?listrowsfirst\>\)\|\%(\%(no_\?\)\?list_rows_first\>\)\|
	\ \%(\%(\<no_\?\)\?listtypes\>\)\|\%(\%(no_\?\)\?list_types\>\)\|
	\ \%(\%(\<no_\?\)\?localloops\>\)\|\%(\%(no_\?\)\?local_loops\>\)\|
	\ \%(\%(\<no_\?\)\?localoptions\>\)\|\%(\%(no_\?\)\?local_options\>\)\|
	\ \%(\%(\<no_\?\)\?localpatterns\>\)\|\%(\%(no_\?\)\?local_patterns\>\)\|
	\ \%(\%(\<no_\?\)\?localtraps\>\)\|\%(\%(no_\?\)\?local_traps\>\)\|
	\ \%(\%(\<no_\?\)\?log\>\)\|
	\ \%(\%(\<no_\?\)\?login\>\)\|
	\ \%(\%(\<no_\?\)\?longlistjobs\>\)\|\%(\%(no_\?\)\?long_list_jobs\>\)\|
	\ \%(\%(\<no_\?\)\?magicequalsubst\>\)\|\%(\%(no_\?\)\?magic_equal_subst\>\)\|
	\ \%(\%(\<no_\?\)\?mark_dirs\>\)\|
	\ \%(\%(\<no_\?\)\?mailwarn\>\)\|\%(\%(no_\?\)\?mail_warn\>\)\|
	\ \%(\%(\<no_\?\)\?mailwarning\>\)\|\%(\%(no_\?\)\?mail_warning\>\)\|
	\ \%(\%(\<no_\?\)\?markdirs\>\)\|
	\ \%(\%(\<no_\?\)\?menucomplete\>\)\|\%(\%(no_\?\)\?menu_complete\>\)\|
	\ \%(\%(\<no_\?\)\?monitor\>\)\|
	\ \%(\%(\<no_\?\)\?multibyte\>\)\|\%(\%(no_\?\)\?multi_byte\>\)\|
	\ \%(\%(\<no_\?\)\?multifuncdef\>\)\|\%(\%(no_\?\)\?multi_func_def\>\)\|
	\ \%(\%(\<no_\?\)\?multios\>\)\|\%(\%(no_\?\)\?multi_os\>\)\|
	\ \%(\%(\<no_\?\)\?nomatch\>\)\|\%(\%(no_\?\)\?no_match\>\)\|
	\ \%(\%(\<no_\?\)\?notify\>\)\|
	\ \%(\%(\<no_\?\)\?nullglob\>\)\|\%(\%(no_\?\)\?null_glob\>\)\|
	\ \%(\%(\<no_\?\)\?numericglobsort\>\)\|\%(\%(no_\?\)\?numeric_glob_sort\>\)\|
	\ \%(\%(\<no_\?\)\?octalzeroes\>\)\|\%(\%(no_\?\)\?octal_zeroes\>\)\|
	\ \%(\%(\<no_\?\)\?onecmd\>\)\|\%(\%(no_\?\)\?one_cmd\>\)\|
	\ \%(\%(\<no_\?\)\?overstrike\>\)\|\%(\%(no_\?\)\?over_strike\>\)\|
	\ \%(\%(\<no_\?\)\?pathdirs\>\)\|\%(\%(no_\?\)\?path_dirs\>\)\|
	\ \%(\%(\<no_\?\)\?pathscript\>\)\|\%(\%(no_\?\)\?path_script\>\)\|
	\ \%(\%(\<no_\?\)\?physical\>\)\|
	\ \%(\%(\<no_\?\)\?pipefail\>\)\|\%(\%(no_\?\)\?pipe_fail\>\)\|
	\ \%(\%(\<no_\?\)\?posixaliases\>\)\|\%(\%(no_\?\)\?posix_aliases\>\)\|
	\ \%(\%(\<no_\?\)\?posixargzero\>\)\|\%(\%(no_\?\)\?posix_arg_zero\>\)\|\%(\%(no_\?\)\?posix_argzero\>\)\|
	\ \%(\%(\<no_\?\)\?posixbuiltins\>\)\|\%(\%(no_\?\)\?posix_builtins\>\)\|
	\ \%(\%(\<no_\?\)\?posixcd\>\)\|\%(\%(no_\?\)\?posix_cd\>\)\|
	\ \%(\%(\<no_\?\)\?posixidentifiers\>\)\|\%(\%(no_\?\)\?posix_identifiers\>\)\|
	\ \%(\%(\<no_\?\)\?posixjobs\>\)\|\%(\%(no_\?\)\?posix_jobs\>\)\|
	\ \%(\%(\<no_\?\)\?posixstrings\>\)\|\%(\%(no_\?\)\?posix_strings\>\)\|
	\ \%(\%(\<no_\?\)\?posixtraps\>\)\|\%(\%(no_\?\)\?posix_traps\>\)\|
	\ \%(\%(\<no_\?\)\?printeightbit\>\)\|\%(\%(no_\?\)\?print_eight_bit\>\)\|
	\ \%(\%(\<no_\?\)\?printexitvalue\>\)\|\%(\%(no_\?\)\?print_exit_value\>\)\|
	\ \%(\%(\<no_\?\)\?privileged\>\)\|
	\ \%(\%(\<no_\?\)\?promptbang\>\)\|\%(\%(no_\?\)\?prompt_bang\>\)\|
	\ \%(\%(\<no_\?\)\?promptcr\>\)\|\%(\%(no_\?\)\?prompt_cr\>\)\|
	\ \%(\%(\<no_\?\)\?promptpercent\>\)\|\%(\%(no_\?\)\?prompt_percent\>\)\|
	\ \%(\%(\<no_\?\)\?promptsp\>\)\|\%(\%(no_\?\)\?prompt_sp\>\)\|
	\ \%(\%(\<no_\?\)\?promptsubst\>\)\|\%(\%(no_\?\)\?prompt_subst\>\)\|
	\ \%(\%(\<no_\?\)\?promptvars\>\)\|\%(\%(no_\?\)\?prompt_vars\>\)\|
	\ \%(\%(\<no_\?\)\?pushdignoredups\>\)\|\%(\%(no_\?\)\?pushd_ignore_dups\>\)\|
	\ \%(\%(\<no_\?\)\?pushdminus\>\)\|\%(\%(no_\?\)\?pushd_minus\>\)\|
	\ \%(\%(\<no_\?\)\?pushdsilent\>\)\|\%(\%(no_\?\)\?pushd_silent\>\)\|
	\ \%(\%(\<no_\?\)\?pushdtohome\>\)\|\%(\%(no_\?\)\?pushd_to_home\>\)\|
	\ \%(\%(\<no_\?\)\?rcexpandparam\>\)\|\%(\%(no_\?\)\?rc_expandparam\>\)\|\%(\%(no_\?\)\?rc_expand_param\>\)\|
	\ \%(\%(\<no_\?\)\?rcquotes\>\)\|\%(\%(no_\?\)\?rc_quotes\>\)\|
	\ \%(\%(\<no_\?\)\?rcs\>\)\|
	\ \%(\%(\<no_\?\)\?recexact\>\)\|\%(\%(no_\?\)\?rec_exact\>\)\|
	\ \%(\%(\<no_\?\)\?rematchpcre\>\)\|\%(\%(no_\?\)\?re_match_pcre\>\)\|\%(\%(no_\?\)\?rematch_pcre\>\)\|
	\ \%(\%(\<no_\?\)\?restricted\>\)\|
	\ \%(\%(\<no_\?\)\?rmstarsilent\>\)\|\%(\%(no_\?\)\?rm_star_silent\>\)\|
	\ \%(\%(\<no_\?\)\?rmstarwait\>\)\|\%(\%(no_\?\)\?rm_star_wait\>\)\|
	\ \%(\%(\<no_\?\)\?sharehistory\>\)\|\%(\%(no_\?\)\?share_history\>\)\|
	\ \%(\%(\<no_\?\)\?shfileexpansion\>\)\|\%(\%(no_\?\)\?sh_file_expansion\>\)\|
	\ \%(\%(\<no_\?\)\?shglob\>\)\|\%(\%(no_\?\)\?sh_glob\>\)\|
	\ \%(\%(\<no_\?\)\?shinstdin\>\)\|\%(\%(no_\?\)\?shin_stdin\>\)\|
	\ \%(\%(\<no_\?\)\?shnullcmd\>\)\|\%(\%(no_\?\)\?sh_nullcmd\>\)\|
	\ \%(\%(\<no_\?\)\?shoptionletters\>\)\|\%(\%(no_\?\)\?sh_option_letters\>\)\|
	\ \%(\%(\<no_\?\)\?shortloops\>\)\|\%(\%(no_\?\)\?short_loops\>\)\|
	\ \%(\%(\<no_\?\)\?shwordsplit\>\)\|\%(\%(no_\?\)\?sh_word_split\>\)\|
	\ \%(\%(\<no_\?\)\?singlecommand\>\)\|\%(\%(no_\?\)\?single_command\>\)\|
	\ \%(\%(\<no_\?\)\?singlelinezle\>\)\|\%(\%(no_\?\)\?single_line_zle\>\)\|
	\ \%(\%(\<no_\?\)\?sourcetrace\>\)\|\%(\%(no_\?\)\?source_trace\>\)\|
	\ \%(\%(\<no_\?\)\?stdin\>\)\|
	\ \%(\%(\<no_\?\)\?sunkeyboardhack\>\)\|\%(\%(no_\?\)\?sun_keyboard_hack\>\)\|
	\ \%(\%(\<no_\?\)\?trackall\>\)\|\%(\%(no_\?\)\?track_all\>\)\|
	\ \%(\%(\<no_\?\)\?transientrprompt\>\)\|\%(\%(no_\?\)\?transient_rprompt\>\)\|
	\ \%(\%(\<no_\?\)\?trapsasync\>\)\|\%(\%(no_\?\)\?traps_async\>\)\|
	\ \%(\%(\<no_\?\)\?typesetsilent\>\)\|\%(\%(no_\?\)\?type_set_silent\>\)\|\%(\%(no_\?\)\?typeset_silent\>\)\|
	\ \%(\%(\<no_\?\)\?unset\>\)\|
	\ \%(\%(\<no_\?\)\?verbose\>\)\|
	\ \%(\%(\<no_\?\)\?vi\>\)\|
	\ \%(\%(\<no_\?\)\?warncreateglobal\>\)\|\%(\%(no_\?\)\?warn_create_global\>\)\|
	\ \%(\%(\<no_\?\)\?xtrace\>\)\|
	\ \%(\%(\<no_\?\)\?zle\>\)/ nextgroup=zshOption skipwhite contained

syn cluster zshDerefs	contains=zshShortDeref,zshLongDeref,zshDeref,zshDollarVar
syn match   zshPreProc	'^\%1l#\%(!\|compdef\|autoload\).*$'
syn match zshShortDere	'\$[!#$*@?_-]\w\@!'
syn match zshShortDere	'\$[=^~]*[#+]*\d\+\>'
syn match zshLongDeref	'\$\%(ARGC\|argv\|status\|pipestatus\|CPUTYPE\|EGID\|EUID\|ERRNO\|GID\|HOST\|LINENO\|LOGNAME\)'
syn match zshLongDeref	'\$\%(MACHTYPE\|OLDPWD OPTARG\|OPTIND\|OSTYPE\|PPID\|PWD\|RANDOM\|SECONDS\|SHLVL\|signals\)'
syn match zshLongDeref	'\$\%(TRY_BLOCK_ERROR\|TTY\|TTYIDLE\|UID\|USERNAME\|VENDOR\|ZSH_NAME\|ZSH_VERSION\|REPLY\|reply\|TERM\)'
"syn match zshVariableDef2	"\<\([bwglsav]:\)\=[a-zA-Z0-9.!@_%+,]*\ze="
syn match shBang	'^\%1l#\!.*$'

syn keyword zshTypes            float integer local typeset declare private
syn match   zshCommands	'\%(^\|\s\)[.:]\ze\s'
syn keyword zshCommands	alias autoload bg bindkey break bye cap cd
		\ chdir clone comparguments compcall compctl command
		\ compdescribe compfiles compgroups compquote
		\ comptags comptry compvalues continue dirs
		\ disable disown echo echotc echoti emulate
		\ enable eval exec exit export false fc fg
		\ functions getcap getln getopts hash history
		\ jobs kill let limit log logout popd print
		\ printf pushd pushln pwd r read readonly
		\ rehash return sched set setcap shift
		\ source stat suspend test times trap true
		\ ttyctl type ulimit umask unalias unfunction
		\ unhash unlimit unset  vared wait
		\ whence where which zcompile zformat zftp zle
		\ zmodload zparseopts zprof zpty zregexparse
		\ zsocket zstyle ztcp
syn keyword zshException        always

"syn region  shDblBrace2 matchgroup=Delimiter start="\[\["	skip=+\%(\\\\\)*\\$+ end="\]\]"	contains=@shTestList,shAstQuote,shNoQuote,shComment
"syn region  shDblParen2 matchgroup=Delimiter start="(("	skip=+\%(\\\\\)*\\$+ end="))"	contains=@shTestList,shComment

" Sync:
hi def link zshDereferencing    PreProc
hi def link zshShortDeref       zshDereferencing
hi def link zshLongDeref        zshDereferencing
hi def link zshDeref            zshDereferencing
hi def link zshCommands         Keyword
hi def link zshOptStart         Keyword
hi def link zshOption           Constant
hi def link zshTypes            Type
"hi def link zshVariableDef2	Identifier
hi def link zshException        Exception
hi def link shDblDelim	Delimiter

" =======================================================================================

" Synchronization: {{{1
" ================
if !exists("g:sh_minlines")
 let s:sh_minlines = 200
else
 let s:sh_minlines= g:sh_minlines
endif
if !exists("g:sh_maxlines")
 let s:sh_maxlines = 2*s:sh_minlines
 if s:sh_maxlines < 25
  let s:sh_maxlines= 25
 endif
else
 let s:sh_maxlines= g:sh_maxlines
endif
exec "syn sync minlines=" . s:sh_minlines . " maxlines=" . s:sh_maxlines
syn sync match shCaseEsacSync	grouphere	shCaseEsac	"\<case\>"
syn sync match shCaseEsacSync	grouphere	shCaseEsac	"\<select\>"
syn sync match shCaseEsacSync	groupthere	shCaseEsac	"\<esac\>"
syn sync match shDoSync	grouphere	shDo	"\<do\>"
syn sync match shDoSync	groupthere	shDo	"\<done\>"
syn sync match shForSync	grouphere	shFor	"\<for\>"
syn sync match shForSync	groupthere	shFor	"\<in\>"
syn sync match shIfSync	grouphere	shIf	"\<if\>"
syn sync match shIfSync	groupthere	shIf	"\<fi\>"
syn sync match shUntilSync	grouphere	shRepeat	"\<until\>"
syn sync match shWhileSync	grouphere	shRepeat	"\<while\>"
syn sync match shRepeatSync	grouphere	shRepeat	"\<repeat\>"

" Default Highlighting: {{{1
" =====================
if !exists("skip_sh_syntax_inits")
 hi def link shArithRegion	shShellVariables
 hi def link shAstQuote	shDoubleQuote
 hi def link shAtExpr	shSetList
 hi def link shBeginHere	shRedir
 hi def link shCaseBar	shConditional
 hi def link shCaseCommandSub	shCommandSub
 hi def link shCaseDoubleQuote	shDoubleQuote
 hi def link shCaseIn	shConditional
 hi def link shQuote	shOperator
 hi def link shCaseSingleQuote	shSingleQuote
 hi def link shCaseStart	shConditional
 hi def link shCmdSubRegion	shShellVariables
 hi def link shColon	shComment
 hi def link shDerefOp	shOperator
 hi def link shDerefPOL	shDerefOp
 hi def link shDerefPPS	shDerefOp
 hi def link shDerefPSR	shDerefOp
 hi def link shDeref	shShellVariables
 hi def link shDerefDelim	shOperator
 hi def link shDerefSimple	shDeref
 hi def link shDerefSpecial	shDeref
 hi def link shDerefString	shDoubleQuote
 hi def link shDerefVar	shDeref
 hi def link shDoubleQuote	shString
 hi def link shEcho	shString
 hi def link shEchoDelim	shOperator
 hi def link shEchoQuote	shString
 hi def link shForPP	shLoop
 hi def link shFunction	Function
 hi def link shEmbeddedEcho	shString
 hi def link shEscape	shCommandSub
 hi def link shExDoubleQuote	shDoubleQuote
 hi def link shExSingleQuote	shSingleQuote
 hi def link shHereDoc	shString
 hi def link shHereString	shRedir
 hi def link shHerePayload	shHereDoc
 hi def link shLoop	shStatement
 hi def link shSpecialNxt	shSpecial
 hi def link shNoQuote	shDoubleQuote
 hi def link shOption	shCommandSub
 hi def link shPattern	shString
 hi def link shParen	shArithmetic
 hi def link shPosnParm	shShellVariables
 hi def link shQuickComment	shComment
 hi def link shRange	shOperator
 hi def link shRedir	shOperator
 hi def link shSetListDelim	shOperator
 hi def link shSetOption	shOption
 hi def link shSingleQuote	shString
 hi def link shSource	shOperator
 hi def link shStringSpecial	shSpecial
 hi def link shSubShRegion	shOperator
 hi def link shTestOpr	shConditional
 hi def link shTestPattern	shString
 hi def link shTestDoubleQuote	shString
 hi def link shTestSingleQuote	shString
 hi def link shTouchCmd	shStatement
 hi def link shVariable	shSetList
 hi def link shWrapLineOperator	shOperator

 if exists("b:is_bash")
   hi def link bashAdminStatement	shStatement
   hi def link bashSpecialVariables	shShellVariables
   hi def link bashStatement		shStatement
   hi def link shCharClass		shSpecial
   hi def link shDerefOff		shDerefOp
   hi def link shDerefLen		shDerefOff
 endif
 if exists("b:is_kornshell")
   hi def link kshSpecialVariables	shShellVariables
   hi def link kshStatement		shStatement
 endif

 if !exists("g:sh_no_error")
  hi def link shCaseError		Error
  hi def link shCondError		Error
  hi def link shCurlyError		Error
  hi def link shDerefOpError		Error
  hi def link shDerefWordError		Error
  hi def link shDoError		Error
  hi def link shEsacError		Error
  hi def link shIfError		Error
  hi def link shInError		Error
  hi def link shParenError		Error
  hi def link shTestError		Error
  if exists("b:is_kornshell")
    hi def link shDTestError		Error
  endif
 endif

 hi def link shArithmetic		Special
 hi def link shCharClass		Identifier
 hi def link shSnglCase		Statement
 hi def link shCommandSub		Special
 hi def link shComment		Comment
 hi def link shConditional		Conditional
 hi def link shCtrlSeq		Special
 hi def link shExprRegion		Delimiter
 hi def link shFunctionKey		Function
 hi def link shFunctionName		Function
 hi def link shNumber		Number
 hi def link shOperator		Operator
 hi def link shRepeat		Repeat
 hi def link shSet		Statement
 hi def link shSetList		Identifier
 hi def link shShellVariables		PreProc
 hi def link shSpecial		Special
 hi def link shSpecialNoZS		shSpecial
 hi def link shStatement		Statement
 hi def link shString		String
 hi def link shTodo		Todo
 hi def link shAlias		Identifier
 hi def link shHereDoc01		shRedir
 hi def link shHereDoc02		shRedir
 hi def link shHereDoc03		shRedir
 hi def link shHereDoc04		shRedir
 hi def link shHereDoc05		shRedir
 hi def link shHereDoc06		shRedir
 hi def link shHereDoc07		shRedir
 hi def link shHereDoc08		shRedir
 hi def link shHereDoc09		shRedir
 hi def link shHereDoc10		shRedir
 hi def link shHereDoc11		shRedir
 hi def link shHereDoc12		shRedir
 hi def link shHereDoc13		shRedir
 hi def link shHereDoc14		shRedir
 hi def link shHereDoc15		shRedir
endif

" Delete shell folding commands {{{1
" =============================
delc ShFoldFunctions
delc ShFoldHereDoc
delc ShFoldIfDoFor

" Set Current Syntax: {{{1
" ===================
let b:current_syntax = "zsh"

" vim: ts=16 fdm=marker nolist
