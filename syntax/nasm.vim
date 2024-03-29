" Vim syntax file
" Language:	NASM - The Netwide Assembler (v0.98)
" Maintainer:	Andrii Sokolov	<andriy145@gmail.com>
" Original Author:	Manuel M.H. Stol	<Manuel.Stol@allieddata.nl>
" Former Maintainer:	Manuel M.H. Stol	<Manuel.Stol@allieddata.nl>
" Contributors: Leonard König <leonard.r.koenig@gmail.com> (C string highlighting)
" Last Change:	2017 Jan 23
" NASM Home:	http://www.nasm.us/



" Setup Syntax:
" quit when a syntax file was already loaded
if exists('b:current_syntax')
  finish
endif
"  Assembler syntax is case insensetive
syn case ignore

" Vim search and movement commands on identifers
"  Comments at start of a line inside which to skip search for indentifiers
setlocal comments=:;
"  Identifier Keyword characters (defines \k)
setlocal iskeyword=@,48-57,#,$,.,?,@-@,_,~


" let g:nasm_loose_syntax = 1
" let g:nasm_no_warn = 1
let g:nasm_ctx_outside_macro = 1

" Comments:
syn region  nasmComment		start=";" keepend end="$" contains=@nasmGrpInComments
syn region  nasmSpecialComment	start=";\*\*\*" keepend end="$"
syn keyword nasmInCommentTodo	contained TODO FIXME XXX[XXXXX]
syn cluster nasmGrpInComments	contains=nasmInCommentTodo
syn cluster nasmGrpComments	contains=@nasmGrpInComments,nasmComment,nasmSpecialComment


" Label Identifiers:
"  in NASM: 'Everything is a Label'
"  Definition Label = label defined by %[i]define or %[i]assign
"  Identifier Label = label defined as first non-keyword on a line or %[i]macro
syn match   nasmLabelError	"$\=\(\d\+\K\|[#.@]\|\$\$\k\)\k*\>"
syn match   nasmLabel		"\<\(\h\|[?@]\)\k*\>"
syn match   nasmLabel		"[\$\~]\(\h\|[?@]\)\k*\>"lc=1
syn match   nasmFuncLabel	"\<\(\h\|[?@]\)\k*\>:"he=e-1
"  Labels starting with one or two '.' are special
syn match   nasmLocalLabel	"\<\.\(\w\|[#$?@~]\)\k*\>"
syn match   nasmLocalLabel	"\<\$\.\(\w\|[#$?@~]\)\k*\>"ms=s+1
if !exists('nasm_no_warn')
  syn match  nasmLabelWarn	"\<\~\=\$\=[_.][_.\~]*\>"
endif
if exists('nasm_loose_syntax')
  syn match   nasmSpecialLabel	"\<\.\.@\k\+\>"
  syn match   nasmSpecialLabel	"\<\$\.\.@\k\+\>"ms=s+1
  if !exists('nasm_no_warn')
    syn match   nasmLabelWarn	"\<\$\=\.\.@\(\d\|[#$\.~]\)\k*\>"
  endif
  " disallow use of nasm internal label format
  syn match   nasmLabelError	"\<\$\=\.\.@\d\+\.\k*\>"
else
  syn match   nasmSpecialLabel	"\<\.\.@\(\h\|[?@]\)\k*\>"
  syn match   nasmSpecialLabel	"\<\$\.\.@\(\h\|[?@]\)\k*\>"ms=s+1
endif
"  Labels can be dereferenced with '$' to destinguish them from reserved words
syn match   nasmLabelError	"\<\$\K\k*\s*:"
syn match   nasmLabelError	"^\s*\$\K\k*\>"
syn match   nasmLabelError	"\<\~\s*\(\k*\s*:\|\$\=\.\k*\)"



" Constants:
syn match   nasmStringError	+["'`]+
" NASM is case sensitive here: eg. u-prefix allows for 4-digit, U-prefix for
" 8-digit Unicode characters
syn case match
" one-char escape-sequences
syn match   nasmCStringEscape  display contained "\\[’"‘\\\?abtnvfre]"
" hex and octal numbers
syn match   nasmCStringEscape  display contained "\\\(x\x\{2}\|\o\{1,3}\)"
" Unicode characters
syn match   nasmCStringEscape	display contained "\\\(u\x\{4}\|U\x\{8}\)"
" ISO C99 format strings (copied from cFormat in runtime/syntax/c.vim)
syn match   nasmCStringFormat	display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlLjzt]\|ll\|hh\)\=\([aAbdiuoxXDOUfFeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
syn match   nasmCStringFormat	display "%%" contained
syn match   nasmString		/\%("[^"]\{-}"\|'[^']\{-}'\)/
" Highlight C escape- and format-sequences within ``-strings
syn match   nasmCString	+\(`[^`]\{-}`\)+ contains=nasmCStringEscape,nasmCStringFormat extend
syn case ignore
syn match   nasmBinNumber	"\<[0-1]\+b\>"
syn match   nasmBinNumber	"\<\~[0-1]\+b\>"lc=1
syn match   nasmOctNumber	"\<\o\+q\>"
syn match   nasmOctNumber	"\<\~\o\+q\>"lc=1
syn match   nasmOctNumber	"\<0o\o\+\>"
syn match   nasmDecNumber	"\<\d\+\>"
syn match   nasmDecNumber	"\<\~\d\+\>"lc=1
syn match   nasmHexNumber	"\<\(\d\x*h\|0x\x\+\|\$\d\x*\)\>"
syn match   nasmHexNumber	"\<\~\(\d\x*h\|0x\x\+\|\$\d\x*\)\>"lc=1
syn match   nasmFltNumber	"\<\d\+\.\d*\(e[+-]\=\d\+\)\=\>"
syn keyword nasmFltNumber	Inf Infinity Indefinite NaN SNaN QNaN
syn match   nasmNumberError	"\<\~\s*\d\+\.\d*\(e[+-]\=\d\+\)\=\>"


" Netwide Assembler Storage Directives:
"  Storage types
syn keyword nasmTypeError	DF EXTRN FWORD RESF TBYTE
syn keyword nasmType		FAR NEAR SHORT
syn keyword nasmType		BYTE WORD DWORD QWORD DQWORD OWORD HWORD DHWORD TWORD
syn keyword nasmType		CDECL FASTCALL NONE PASCAL STDCALL
syn keyword nasmStorage		EXTERN GLOBAL COMMON
syn keyword nasmStorage		DB DW DD DQ DDQ DT
syn keyword nasmStorage		RESB RESW RESD RESQ RESDQ REST
syn case match
syn keyword nasmStorage		DO RESO
syn case ignore

"  Structured storage types
syn match   nasmTypeError	"\<\(AT\|I\=\(END\)\=\(STRUCT\=\|UNION\)\|I\=END\)\>"
syn match   nasmStructureLabel	contained "\<\(AT\|I\=\(END\)\=\(STRUCT\=\|UNION\)\|I\=END\)\>"
"   structures cannot be nested (yet) -> use: 'keepend' and 're='
syn cluster nasmGrpCntnStruc	contains=ALLBUT,@nasmGrpInComments,nasmMacroDef,@nasmGrpInMacros,@nasmGrpInPreCondits,nasmStructureDef,@nasmGrpInStrucs
syn region  nasmStructureDef	transparent matchgroup=nasmStructure keepend start="^\s*STRUCT\>"hs=e-5 end="^\s*ENDSTRUCT\>"re=e-9 contains=@nasmGrpCntnStruc
syn region  nasmStructureDef	transparent matchgroup=nasmStructure keepend start="^\s*STRUC\>"hs=e-4  end="^\s*ENDSTRUC\>"re=e-8  contains=@nasmGrpCntnStruc
syn region  nasmStructureDef	transparent matchgroup=nasmStructure keepend start="\<ISTRUCT\=\>" end="\<IEND\(STRUCT\=\)\=\>" contains=@nasmGrpCntnStruc,nasmInStructure
"   union types are not part of nasm (yet)
"syn region  nasmStructureDef	transparent matchgroup=nasmStructure keepend start="^\s*UNION\>"hs=e-4 end="^\s*ENDUNION\>"re=e-8 contains=@nasmGrpCntnStruc
"syn region  nasmStructureDef	transparent matchgroup=nasmStructure keepend start="\<IUNION\>" end="\<IEND\(UNION\)\=\>" contains=@nasmGrpCntnStruc,nasmInStructure
syn match   nasmInStructure	contained "^\s*AT\>"hs=e-1
syn cluster nasmGrpInStrucs	contains=nasmStructure,nasmInStructure,nasmStructureLabel



" PreProcessor Instructions:
" NAsm PreProcs start with %, but % is not a character
syn match   nasmPreProcError	"%{\=\(%\=\k\+\|%%\+\k*\|[+-]\=\d\+\)}\="
if exists('nasm_loose_syntax')
  syn cluster nasmGrpNxtCtx	contains=nasmStructureLabel,nasmLabel,nasmLocalLabel,nasmSpecialLabel,nasmLabelError,nasmPreProcError
else
  syn cluster nasmGrpNxtCtx	contains=nasmStructureLabel,nasmLabel,nasmLabelError,nasmPreProcError
endif


"  Multi-line macro
syn cluster nasmGrpCntnMacro	contains=ALLBUT,@nasmGrpInComments,nasmStructureDef,@nasmGrpInStrucs,nasmMacroDef,@nasmGrpPreCondits,nasmMemReference,nasmInMacPreCondit,nasmInMacStrucDef
syn region  nasmMacroDef	matchgroup=nasmMacro keepend start="^\s*%macro\>"hs=e-5 start="^\s*%imacro\>"hs=e-6 end="^\s*%endmacro\>"re=e-9 contains=@nasmGrpCntnMacro,nasmInMacStrucDef
if exists('nasm_loose_syntax')
  syn match  nasmInMacLabel	contained "%\(%\k\+\>\|{%\k\+}\)"
  syn match  nasmInMacLabel	contained "%\($\+\(\w\|[#\.?@~]\)\k*\>\|{$\+\(\w\|[#\.?@~]\)\k*}\)"
  syn match  nasmInMacPreProc	contained "^\s*%\(push\|repl\)\>"hs=e-4 skipwhite nextgroup=nasmStructureLabel,nasmLabel,nasmInMacParam,nasmLocalLabel,nasmSpecialLabel,nasmLabelError,nasmPreProcError
  if !exists('nasm_no_warn')
    syn match nasmInMacLblWarn	contained "%\(%[$\.]\k*\>\|{%[$\.]\k*}\)"
    syn match nasmInMacLblWarn	contained "%\($\+\(\d\|[#\.@~]\)\k*\|{\$\+\(\d\|[#\.@~]\)\k*}\)"
    hi link nasmInMacCatLabel	nasmInMacLblWarn
  else
    hi link nasmInMacCatLabel	nasmInMacLabel
  endif
else
  syn match  nasmInMacLabel	contained "%\(%\(\w\|[#?@~]\)\k*\>\|{%\(\w\|[#?@~]\)\k*}\)"
  syn match  nasmInMacLabel	contained "%\($\+\(\h\|[?@]\)\k*\>\|{$\+\(\h\|[?@]\)\k*}\)"
  hi link nasmInMacCatLabel	nasmLabelError
endif
syn match   nasmInMacCatLabel	contained "\d\K\k*"lc=1
syn match   nasmInMacLabel	contained "\d}\k\+"lc=2
if !exists('nasm_no_warn')
  syn match  nasmInMacLblWarn	contained "%\(\($\+\|%\)[_~][._~]*\>\|{\($\+\|%\)[_~][._~]*}\)"
endif
syn match   nasmInMacPreProc	contained "^\s*%pop\>"hs=e-3
syn match   nasmInMacPreProc	contained "^\s*%\(push\|repl\)\>"hs=e-4 skipwhite nextgroup=@nasmGrpNxtCtx
"   structures cannot be nested (yet) -> use: 'keepend' and 're='
syn region  nasmInMacStrucDef	contained transparent matchgroup=nasmStructure keepend start="^\s*STRUCT\>"hs=e-5 end="^\s*ENDSTRUCT\>"re=e-9 contains=@nasmGrpCntnMacro
syn region  nasmInMacStrucDef	contained transparent matchgroup=nasmStructure keepend start="^\s*STRUC\>"hs=e-4  end="^\s*ENDSTRUC\>"re=e-8  contains=@nasmGrpCntnMacro
syn region  nasmInMacStrucDef	contained transparent matchgroup=nasmStructure keepend start="\<ISTRUCT\=\>" end="\<IEND\(STRUCT\=\)\=\>" contains=@nasmGrpCntnMacro,nasmInStructure
"   union types are not part of nasm (yet)
"syn region  nasmInMacStrucDef	contained transparent matchgroup=nasmStructure keepend start="^\s*UNION\>"hs=e-4 end="^\s*ENDUNION\>"re=e-8 contains=@nasmGrpCntnMacro
"syn region  nasmInMacStrucDef	contained transparent matchgroup=nasmStructure keepend start="\<IUNION\>" end="\<IEND\(UNION\)\=\>" contains=@nasmGrpCntnMacro,nasmInStructure
syn region  nasmInMacPreConDef	contained transparent matchgroup=nasmInMacPreCondit start="^\s*%if\%(nidni\|token\)\>"hs=e-7 start="^\s*%if\(idni\|n\(ctx\|def\|idn\|num\|str\)\)\>"hs=e-6 start="^\s*%if\(ctx\|def\|idn\|nid\|num\|str\)\>"hs=e-5 start="^\s*%ifid\>"hs=e-4 start="^\s*%if\>"hs=e-2 end="%endif\>" contains=@nasmGrpCntnMacro,nasmInMacPreCondit,nasmInPreCondit
" Todo: allow STRUC/ISTRUC to be used inside preprocessor conditional block
syn match   nasmInMacPreCondit	contained transparent "ctx\s"lc=3 skipwhite nextgroup=@nasmGrpNxtCtx
syn match   nasmInMacPreCondit	contained "^\s*%elifctx\>"hs=e-7 skipwhite nextgroup=@nasmGrpNxtCtx
syn match   nasmInMacPreCondit	contained "^\s*%elifnctx\>"hs=e-8 skipwhite nextgroup=@nasmGrpNxtCtx
syn match   nasmInMacParamNum	contained "\<\d\+\.list\>"me=e-5
syn match   nasmInMacParamNum	contained "\<\d\+\.nolist\>"me=e-7
syn match   nasmInMacDirective	contained "\.\(no\)\=list\>"
syn match   nasmInMacMacro	contained transparent "macro\s"lc=5 skipwhite nextgroup=nasmStructureLabel
syn match   nasmInMacMacro	contained "^\s*%rotate\>"hs=e-6
syn match   nasmInMacParam	contained "%\([+-]\=\d\+\|{[+-]\=\d\+}\)"
"   nasm conditional macro operands/arguments
"   Todo: check feasebility; add too nasmGrpInMacros, etc.
"syn match   nasmInMacCond	contained "\<\(N\=\([ABGL]E\=\|[CEOSZ]\)\|P[EO]\=\)\>"
syn cluster nasmGrpInMacros	contains=nasmMacro,nasmInMacMacro,nasmInMacParam,nasmInMacParamNum,nasmInMacDirective,nasmInMacLabel,nasmInMacLblWarn,nasmInMacMemRef,nasmInMacPreConDef,nasmInMacPreCondit,nasmInMacPreProc,nasmInMacStrucDef

"   Context pre-procs that are better used inside a macro
if exists('nasm_ctx_outside_macro')
  syn region nasmPreConditDef	transparent matchgroup=nasmCtxPreCondit start="^\s*%ifnctx\>"hs=e-6 start="^\s*%ifctx\>"hs=e-5 end="%endif\>" contains=@nasmGrpCntnPreCon
  syn match  nasmCtxPreProc	"^\s*%pop\>"hs=e-3
  if exists('nasm_loose_syntax')
    syn match   nasmCtxLocLabel	"%$\+\(\w\|[#.?@~]\)\k*\>"
  else
    syn match   nasmCtxLocLabel	"%$\+\(\h\|[?@]\)\k*\>"
  endif
  syn match nasmCtxPreProc	"^\s*%\(push\|repl\)\>"hs=e-4 skipwhite nextgroup=@nasmGrpNxtCtx
  syn match nasmCtxPreCondit	contained transparent "ctx\s"lc=3 skipwhite nextgroup=@nasmGrpNxtCtx
  syn match nasmCtxPreCondit	contained "^\s*%elifctx\>"hs=e-7 skipwhite nextgroup=@nasmGrpNxtCtx
  syn match nasmCtxPreCondit	contained "^\s*%elifnctx\>"hs=e-8 skipwhite nextgroup=@nasmGrpNxtCtx
  if exists('nasm_no_warn')
    hi link nasmCtxPreCondit	nasmPreCondit
    hi link nasmCtxPreProc	nasmPreProc
    hi link nasmCtxLocLabel	nasmLocalLabel
  else
    hi link nasmCtxPreCondit	nasmPreProcWarn
    hi link nasmCtxPreProc	nasmPreProcWarn
    hi link nasmCtxLocLabel	nasmLabelWarn
  endif
endif

"  Conditional assembly
" syn cluster nasmGrpCntnPreCon	contains=ALLBUT,@nasmGrpInComments,@nasmGrpInMacros,@nasmGrpInStrucs
syn cluster nasmGrpCntnPreCon	contains=ALLBUT,@nasmGrpInComments,@nasmGrpInMacros,@nasmGrpInStrucs
syn region  nasmPreConditDef	transparent matchgroup=nasmPreCondit start="^\s*%if\%(nidni\|token\)\>"hs=e-7 start="^\s*%if\(idni\|n\(def\|idn\|num\|str\)\)\>"hs=e-6 start="^\s*%if\(def\|idn\|nid\|num\|str\)\>"hs=e-5 start="^\s*%ifid\>"hs=e-4 start="^\s*%if\>"hs=e-2 end="%endif\>" contains=@nasmGrpCntnPreCon
syn match   nasmInPreCondit	contained "^\s*%el\(if\|se\)\>"hs=e-4
syn match   nasmInPreCondit	contained "^\s*%elifid\>"hs=e-6
syn match   nasmInPreCondit	contained "^\s*%elif\(def\|idn\|nid\|num\|str\)\>"hs=e-7
syn match   nasmInPreCondit	contained "^\s*%elif\(n\(def\|idn\|num\|str\)\|idni\)\>"hs=e-8
syn match   nasmInPreCondit	contained "^\s*%elif\%(nidni\|token\)\>"hs=e-9
syn cluster nasmGrpInPreCondits	contains=nasmPreCondit,nasmInPreCondit,nasmCtxPreCondit
syn cluster nasmGrpPreCondits	contains=nasmPreConditDef,@nasmGrpInPreCondits,nasmCtxPreProc,nasmCtxLocLabel

"  Other pre-processor statements
syn match   nasmPreProc		"^\s*%\%(rep\|use\)\>"hs=e-3
syn match   nasmPreProc		"^\s*%line\>"hs=e-4
syn match   nasmPreProc		"^\s*%\%(endrep\|strlen\|substr\|strcat\|defstr\|deftok\|pragma\)\>"hs=e-6
syn match   nasmPreProc		"^\s*%\%(exitrep\|warning\)\>"hs=e-7
syn match   nasmPreProc		"^\s*%\%(clear\|error\|fatal\)\>"
syn region  nasmPPMsg		 matchgroup=nasmPreProc start="^\s*%\%(warning\|error\|fatal\)\>" end="\n"

syn match   nasmDefine		"^\s*%undef\>"hs=e-5
syn match   nasmDefine		"^\s*%\%(assign\|define\)\>"hs=e-6
syn match   nasmDefine		"^\s*%\%(assign\|define\|defstr\|deftok\)\>"hs=e-6
syn match   nasmDefine		"^\s*%i\%(assign\|define\)\>"hs=e-7
syn match   nasmDefine		"^\s*%x\%(assign\|define\)\>"hs=e-7
syn match   nasmDefine		"^\s*%ix\%(assign\|define\)\>"hs=e-8
syn match   nasmDefine		"^\s*%unmacro\>"hs=e-7
syn match   nasmInclude		"^\s*%include\>"hs=e-7
" Todo: Treat the line tail after %fatal, %error, %warning as text

syn match   nasmPunct		"[()+\-*/<>!=]"

"  Multiple pre-processor instructions on single line detection (obsolete)
"syn match   nasmPreProcError	+^\s*\([^\t "%';][^"%';]*\|[^\t "';][^"%';]\+\)%\a\+\>+
syn cluster nasmGrpPreProcs	contains=nasmMacroDef,@nasmGrpInMacros,@nasmGrpPreCondits,nasmPreProc,nasmDefine,nasmInclude,nasmPreProcWarn,nasmPreProcError,nasmPunct



" Register Identifiers:
"  Register operands:
syn match   nasmGen08Register	"\<[A-D][HL]\>"
syn match   nasmGen16Register	"\<\%([A-D]X\|[DS]I\|[BS]P\)\>"
syn match   nasmGen32Register	"\<E\%([A-D]X\|[DS]I\|[BS]P\)\>"
syn match   nasmGen64Register	"\<R\%([A-D]X\|[DS]I\|[BS]P\|[89]\|1[0-5]\|[89][WDB]\|1[0-5][WDB]\)\>"
syn match   nasmExtRegister     "\<\%([SB]PL\|[SD]IL\)\>"
syn match   nasmSegRegister	"\<[C-GS]S\>"
syn match   nasmSpcRegister	"\<E\=IP\>"
syn match   nasmFpuRegister	"\<ST\o\>"
syn match   nasmMmxRegister	"\<MM\o\>"
syn match   nasmSseRegister	"\<XMM\d[0-5]\=\>"
syn match   nasmAvxRegister	"\<YMM\d[0-5]\=\>"
syn match   nasmAvx512Register	"\<ZMM\%([12]\d\|3[01]\|\d\)\>"
syn match   nasmAvx512Register	"\<K[0-7]\>"
syn match   nasmCtrlRegister	"\<CR\o\>"
syn match   nasmDebugRegister	"\<DR\o\>"
syn match   nasmTestRegister	"\<TR\o\>"
syn match   nasmRegisterError	"\<\%(CR[15-9]\|DR[4-58-9]\|TR[0-28-9]\)\>"
syn match   nasmRegisterError	"\<X\=MM[8-9]\>"
syn match   nasmRegisterError	"\<ST\%((\d)\|[8-9]\>\)"
syn match   nasmRegisterError	"\<E\%([A-D][HL]\|[C-GS]S\)\>"
"  Memory reference operand (address):
syn match   nasmMemRefError	"[[\]]"
syn cluster nasmGrpCntnMemRef	contains=ALLBUT,@nasmGrpComments,@nasmGrpPreProcs,@nasmGrpInStrucs,nasmMemReference,nasmMemRefError
syn match   nasmInMacMemRef	contained "\[[^;[\]]\{-}\]" contains=@nasmGrpCntnMemRef,nasmPreProcError,nasmInMacLabel,nasmInMacLblWarn,nasmInMacParam
syn match   nasmMemReference	"\[[^;[\]]\{-}\]" contains=@nasmGrpCntnMemRef,nasmPreProcError,nasmCtxLocLabel



" Netwide Assembler Directives:
"  Compilation constants
syn keyword nasmConstant	__BITS__ __DATE__ __FILE__ __FORMAT__ __LINE__
syn keyword nasmConstant	__NASM_MAJOR__ __NASM_MINOR__ __NASM_VERSION__
syn keyword nasmConstant	__TIME__
syn keyword nasmSpecialMacro	__float32__ __float64__
"  Instruction modifiers
syn match   nasmInstructnError	"\<TO\>"
syn match   nasmInstrModifier	"\(^\|:\)\s*[C-GS]S\>"ms=e-1
syn keyword nasmInstrModifier	A16 A32 O16 O32
syn match   nasmInstrModifier	"\<F\(ADD\|MUL\|\(DIV\|SUB\)R\=\)\s\+TO\>"lc=5,ms=e-1
"   the 'to' keyword is not allowed for fpu-pop instructions (yet)
"syn match   nasmInstrModifier	"\<F\(ADD\|MUL\|\(DIV\|SUB\)R\=\)P\s\+TO\>"lc=6,ms=e-1
"  NAsm directives
syn keyword nasmRepeat		TIMES
syn keyword nasmDirective	ALIGN[B] INCBIN EQU NOSPLIT SPLIT
syn keyword nasmDirective	ABSOLUTE BITS SECTION SEGMENT
syn keyword nasmDirective	ENDSECTION ENDSEGMENT
syn keyword nasmDirective	__SECT__
"  Macro created standard directives: (requires %include)
syn case match
syn keyword nasmStdDirective	EPILOGUE PROLOGUE
syn keyword nasmStdDirective	ENDIF ELSE ELIF ELSIF IF
syn keyword nasmStdDirective	THEN LAND LOR
"syn keyword nasmStdDirective	PROC ENDPROC LOCALS USES
"syn keyword nasmStdDirective	BREAK CASE DEFAULT ENDSWITCH SWITCH
"syn keyword nasmStdDirective	CASE OF ENDCASE
"syn keyword nasmStdDirective	DO ENDFOR ENDWHILE FOR REPEAT UNTIL WHILE EXIT
syn case ignore
"  Format specific directives: (all formats)
"  (excluded: extension directives to section, global, common and extern)
syn keyword nasmFmtDirective	ORG
" syn keyword nasmFmtDirective	EXPORT IMPORT 
syn keyword nasmFmtDirective	GROUP UPPERCASE SEG
syn keyword nasmFmtDirective	LIBRARY
syn keyword nasmWRT		WRT

syn case match
syn keyword nasmFmtDirective	_GLOBAL_OFFSET_TABLE_ __GLOBAL_OFFSET_TABLE_
syn keyword nasmWRTlocation	..start ..got ..gotoff ..gotpc ..plt ..sym

syn case ignore

syn keyword nasmDirective	DEFAULT
syn keyword nasmStorageModifier	REL ABS BND NOBND


" Standard Instructions:
syn match   nasmInstructnError	"\<\(F\=CMOV\|SET\)N\=\a\{0,2}\>"
syn keyword nasmInstructnError	CMPS MOVS LCS LODS STOS XLAT
syn match   nasmStdInstruction	"\<MOV\>"
syn match   nasmInstructnError	"\<MOV\s[^,;[]*\<CS\>\s*[^:]"he=e-1
syn match   nasmStdInstruction	"\<\(CMOV\|J\|SET\)\(N\=\([ABGL]E\=\|[CEOSZ]\)\|P[EO]\=\)\>"
syn match   nasmStdInstruction	"\<POP\>"
syn keyword nasmStdInstruction	AAA AAD AAM AAS ADC ADD AND
syn keyword nasmStdInstruction	BOUND BSF BSR BSWAP BT[C] BTR BTS
syn keyword nasmStdInstruction	CALL CBW CDQ CLC CLD CMC CMP CMPSB CMPSD CMPSW CMPSQ
syn keyword nasmStdInstruction	CMPXCHG CMPXCHG8B CPUID CWD[E] CQO
syn keyword nasmStdInstruction	DAA DAS DEC DIV ENTER
syn keyword nasmStdInstruction	IDIV IMUL INC INT[O] IRET[D] IRETW IRETQ
syn keyword nasmStdInstruction	JCXZ JECXZ JMP
syn keyword nasmStdInstruction	LAHF LDS LEA LEAVE LES LFS LGS LODSB LODSD LODSQ
syn keyword nasmStdInstruction	LODSW LOOP[E] LOOPNE LOOPNZ LOOPZ LSS
syn keyword nasmStdInstruction	MOVSB MOVSD MOVSW MOVSX MOVSQ MOVZX MUL NEG NOP NOT
syn keyword nasmStdInstruction	OR POPA[D] POPAW POPF[D] POPFW POPFQ
syn keyword nasmStdInstruction	PUSH[AD] PUSHAW PUSHF[D] PUSHFW PUSHFQ
syn keyword nasmStdInstruction	RCL RCR RETF RET[N] ROL ROR
syn keyword nasmStdInstruction	SAHF SAL SAR SBB SCASB SCASD SCASW
syn keyword nasmStdInstruction	SHL[D] SHR[D] STC STD STOSB STOSD STOSW STOSQ SUB
syn keyword nasmStdInstruction	TEST XADD XCHG XLATB XOR
syn keyword nasmStdInstruction	LFENCE MFENCE SFENCE


" System Instructions: (usually privileged)
"  Verification of pointer parameters
syn keyword nasmSysInstruction	ARPL LAR LSL VERR VERW
"  Addressing descriptor tables
syn keyword nasmSysInstruction	LLDT SLDT LGDT SGDT
"  Multitasking
syn keyword nasmSysInstruction	LTR STR
"  Coprocessing and Multiprocessing (requires fpu and multiple cpu's resp.)
syn keyword nasmSysInstruction	CLTS LOCK WAIT
"  Input and Output
syn keyword nasmInstructnError	INS OUTS
syn keyword nasmSysInstruction	IN INSB INSW INSD OUT OUTSB OUTSB OUTSW OUTSD
"  Interrupt control
syn keyword nasmSysInstruction	CLI STI LIDT SIDT
"  System control
syn match   nasmSysInstruction	"\<MOV\s[^;]\{-}\<CR\o\>"me=s+3
syn keyword nasmSysInstruction	HLT INVD LMSW
syn keyword nasmSseInstruction	PREFETCHT0 PREFETCHT1 PREFETCHT2 PREFETCHNTA
syn keyword nasmSseInstruction	RSM SFENCE SMSW SYSENTER SYSEXIT UD2 WBINVD
"  TLB (Translation Lookahead Buffer) testing
syn match   nasmSysInstruction	"\<MOV\s[^;]\{-}\<TR\o\>"me=s+3
syn keyword nasmSysInstruction	INVLPG

" Debugging Instructions: (privileged)
syn match   nasmDbgInstruction	"\<MOV\s[^;]\{-}\<DR\o\>"me=s+3
syn keyword nasmDbgInstruction	INT1 INT3 RDMSR RDTSC RDPMC WRMSR


" Floating Point Instructions: (requires FPU)
syn match   nasmFpuInstruction	"\<FCMOVN\=\([AB]E\=\|[CEPUZ]\)\>"
syn keyword nasmFpuInstruction	F2XM1 FABS FADD[P] FBLD FBSTP
syn keyword nasmFpuInstruction	FCHS FCLEX FCOM[IP] FCOMP[P] FCOS
syn keyword nasmFpuInstruction	FDECSTP FDISI FDIV[P] FDIVR[P] FENI FFREE
syn keyword nasmFpuInstruction	FIADD FICOM[P] FIDIV[R] FILD
syn keyword nasmFpuInstruction	FIMUL FINCSTP FINIT FIST[P] FISUB[R]
syn keyword nasmFpuInstruction	FLD[1] FLDCW FLDENV FLDL2E FLDL2T FLDLG2
syn keyword nasmFpuInstruction	FLDLN2 FLDPI FLDZ FMUL[P]
syn keyword nasmFpuInstruction	FNCLEX FNDISI FNENI FNINIT FNOP FNSAVE
syn keyword nasmFpuInstruction	FNSTCW FNSTENV FNSTSW FNSTSW
syn keyword nasmFpuInstruction	FPATAN FPREM[1] FPTAN FRNDINT FRSTOR
syn keyword nasmFpuInstruction	FSAVE FSCALE FSETPM FSIN FSINCOS FSQRT
syn keyword nasmFpuInstruction	FSTCW FSTENV FST[P] FSTSW FSUB[P] FSUBR[P]
syn keyword nasmFpuInstruction	FTST FUCOM[IP] FUCOMP[P]
syn keyword nasmFpuInstruction	FXAM FXCH FXTRACT FYL2X FYL2XP1


" Multi Media Xtension Packed Instructions: (requires MMX unit)
"  Standard MMX instructions: (requires MMX1 unit)
syn match   nasmInstructnError	"\<P\(ADD\|SUB\)U\=S\=[DQ]\=\>"
syn match   nasmInstructnError	"\<PCMP\a\{0,2}[BDWQ]\=\>"
syn keyword nasmMmxInstruction	EMMS MOVD MOVQ
syn keyword nasmMmxInstruction	PACKSSDW PACKSSWB PACKUSWB PADDB PADDD PADDW
syn keyword nasmMmxInstruction	PADDSB PADDSW PADDUSB PADDUSW PAND[N]
syn keyword nasmMmxInstruction	PCMPEQB PCMPEQD PCMPEQW PCMPGTB PCMPGTD PCMPGTW
syn keyword nasmMmxInstruction	PMACHRIW PMADDWD PMULHW PMULLW POR
syn keyword nasmMmxInstruction	PSLLD PSLLQ PSLLW PSRAD PSRAW PSRLD PSRLQ PSRLW
syn keyword nasmMmxInstruction	PSUBB PSUBD PSUBW PSUBSB PSUBSW PSUBUSB PSUBUSW
syn keyword nasmMmxInstruction	PUNPCKHBW PUNPCKHDQ PUNPCKHWD
syn keyword nasmMmxInstruction	PUNPCKLBW PUNPCKLDQ PUNPCKLWD PXOR
"  Extended MMX instructions: (requires MMX2/SSE unit)
syn keyword nasmMmxInstruction	MASKMOVQ MOVNTQ
syn keyword nasmMmxInstruction	PAVGB PAVGW PEXTRW PINSRW PMAXSW PMAXUB
syn keyword nasmMmxInstruction	PMINSW PMINUB PMOVMSKB PMULHUW PSADBW PSHUFW


" Streaming SIMD Extension Packed Instructions: (requires SSE unit)
syn match   nasmInstructnError	"\<CMP\a\{1,5}[PS]S\>"
syn match   nasmSseInstruction	"\<CMP\(N\=\(EQ\|L[ET]\)\|\(UN\)\=ORD\)\=[PS]S\>"
syn keyword nasmSseInstruction	ADDPS ADDSS ANDNPS ANDPS
syn keyword nasmSseInstruction	ADDSD SUBSD MULSD DIVSD
syn keyword nasmSseInstruction	COMISS CVTPI2PS CVTPS2PI
syn keyword nasmSseInstruction	CVTSI2SS CVTSS2SI CVTTPS2PI CVTTSS2SI
syn keyword nasmSseInstruction	DIVPS DIVSS FXRSTOR FXSAVE LDMXCSR
syn keyword nasmSseInstruction	MAXPS MAXSS MINPS MINSS MOVAPS MOVHLPS MOVHPS
syn keyword nasmSseInstruction	MOVLHPS MOVLPS MOVMSKPS MOVNTPS MOVSS MOVUPS
syn keyword nasmSseInstruction	MULPS MULSS
syn keyword nasmSseInstruction	ORPS RCPPS RCPSS RSQRTPS RSQRTSS
syn keyword nasmSseInstruction	SHUFPS SQRTPS SQRTSS STMXCSR SUBPS SUBSS SQRTSD
syn keyword nasmSseInstruction	UCOMISS UNPCKHPS UNPCKLPS XORPS


" Three Dimensional Now Packed Instructions: (requires 3DNow! unit)
syn keyword nasmNowInstruction	FEMMS PAVGUSB PF2ID PFACC PFADD PFCMPEQ PFCMPGE
syn keyword nasmNowInstruction	PFCMPGT PFMAX PFMIN PFMUL PFRCP PFRCPIT1
syn keyword nasmNowInstruction	PFRCPIT2 PFRSQIT1 PFRSQRT PFSUB[R] PI2FD
syn keyword nasmNowInstruction	PMULHRWA PREFETCH[W]


" Vendor Specific Instructions:
"  Cyrix instructions (requires Cyrix processor)
syn keyword nasmCrxInstruction	PADDSIW PAVEB PDISTIB PMAGW PMULHRW[C] PMULHRIW
syn keyword nasmCrxInstruction	PMVGEZB PMVLZB PMVNZB PMVZB PSUBSIW
syn keyword nasmCrxInstruction	RDSHR RSDC RSLDT SMINT SMINTOLD SVDC SVLDT SVTS
syn keyword nasmCrxInstruction	WRSHR
"  AMD instructions (requires AMD processor)
syn keyword nasmAmdInstruction	SYSCALL SYSRET


" Undocumented Instructions:
syn match   nasmUndInstruction	"\<POP\s[^;]*\<CS\>"me=s+3
syn keyword nasmUndInstruction	CMPXCHG486 IBTS ICEBP INT01 INT03 LOADALL
syn keyword nasmUndInstruction	LOADALL286 LOADALL386 SALC SMI UD1 UMOV XBTS


" Additional Modern Instructions: (BMI, BMI2, AVX, AVX2)
syn keyword nasmBmiInstruction  ANDN BEXTR BLSI BLSMSK BLSR TZCNT POPCNT LZCNT
syn keyword nasmBmiInstruction  PDEP PEXT BZHI MULX RORX SARX SHRX SHLX
syn match   nasmAvxInstruction  /\<VBROADCAST\%(S[DS]\|[FI]128\)\>/
syn match   nasmAvxInstruction  /\<VPBROADCAST[BWDQ]\>/
syn keyword nasmAvxInstruction  VINSERTI128 VINSERTF128 VEXTRACTI128 VEXTRACTF128
syn keyword nasmAvxInstruction  VZEROALL VZEROUPPER VPBLENDD VPSRAVD
syn match   nasmAvxInstruction "\<VMASKMOVP[SD]\>"
syn match   nasmAvxInstruction /\<VPMASKMOV[DQ]\>/
syn match   nasmAvxInstruction /\<VGATHER[DQ]P[DS]\>/
syn match   nasmAvxInstruction /\<VPGATHER[DQ][DQ]\>/
syn match   nasmAvxInstruction /\<VPERM\%(ILP[SD]\|2[FI]128\|P[SD]\|[DQ]\)\>/
syn match   nasmAvxInstruction /\<VPS[LR]LV[DQ]\>/
syn match   nasmAvxInstruction /\<VMOVDQ\%(A\%(64\|32\)\=\|U\%(8\|16\|32\|64\)\)\=\>/

syn keyword nasmAvx512Instruction SQRTS[DS] VSQRTS[DS]


" Some junk:
syn case match
syn keyword nasmNasmxKeyword  DEFAULT 
syn case ignore
syn keyword nasmNasmxKeyword  INVOKE USES CASE NASMX_AT LOCAL
syn keyword nasmNasmxType     NASMX_STRUC NASMX_UNION NASMX_CLASS NASMX_ALIGN NASMX_RESERVE
syn keyword nasmNasmxType     NASMX_ENDSTRUC NASMX_ENDUNION NASMX_ENDCLASS
syn keyword nasmNasmxKeywordStrong SWITCH CONTINUE BREAK RETURN
syn keyword nasmNasmxKeywordStrong ENTRY LOCALS PROC
syn keyword nasmNasmxKeywordStrong ENDSWITCH ENDLOCALS ENDPROC
syn keyword nasmNasmxKeywordStrong IMPORT

syn case match
syn keyword nasmNasmxPlusKeywordStrong APROC 
syn case ignore

syn match   nasmNasmxMacro    "\<\%(var\|argv\|[@]\)\>"

hi def link nasmNasmxPlusKeywordStrong  nasmNasmxKeywordStrong
hi def link nasmNasmxKeyword		PreProc
hi def link nasmNasmxType		Type
hi def link nasmNasmxKeywordStrong	Method
hi def link nasmNasmxMacro		PreProc


" Synchronize Syntax:
syn sync clear
syn sync minlines=50		"for multiple region nesting
syn sync match  nasmSync	grouphere nasmMacroDef "^\s*%i\=macro\>"me=s-1
syn sync match	nasmSync	grouphere NONE	       "^\s*%endmacro\>"


" Define the default highlighting.
" Only when an item doesn't have highlighting yet

" Sub Links:
hi def link nasmInMacDirective	nasmDirective
hi def link nasmInMacLabel	nasmLocalLabel
hi def link nasmInMacLblWarn	nasmLabelWarn
hi def link nasmInMacMacro	nasmMacro
hi def link nasmInMacParam	nasmMacro
hi def link nasmInMacParamNum	nasmDecNumber
hi def link nasmInMacPreCondit	nasmPreCondit
hi def link nasmInMacPreProc	nasmPreProc
hi def link nasmInPreCondit	nasmPreCondit
hi def link nasmInStructure	nasmStructure
hi def link nasmStructureLabel	nasmStructure

" Comment Group:
hi def link nasmComment		Comment
hi def link nasmSpecialComment	SpecialComment
hi def link nasmInCommentTodo	Todo

" Constant Group:
hi def link nasmString		String
hi def link nasmCString		String
hi def link nasmStringError	Error
hi def link nasmCStringEscape	Special
hi def link nasmCStringFormat	SpecialChar
hi def link nasmBinNumber	Number
hi def link nasmOctNumber	Number
hi def link nasmDecNumber	Number
hi def link nasmHexNumber	Number
hi def link nasmFltNumber	Float
hi def link nasmNumberError	Error

" Identifier Group:
hi def link nasmLabel		Identifier
hi def link nasmLocalLabel	Identifier
hi def link nasmSpecialLabel	Special
hi def link nasmLabelError	Error
hi def link nasmLabelWarn	Todo

hi def link nasmFuncLabel	Function

" PreProc Group:
hi def link nasmPreProc		PreCondit
hi def link nasmDefine		c_preproc
hi def link nasmInclude		PreCondit
hi def link nasmMacro		c_preproc
hi def link nasmPreCondit	PreProc
hi def link nasmPreProcError	Error
hi def link nasmPreProcWarn	Todo

hi def link nasmSpecialMacro	Operator

hi def link nasmPPMsg		String

" Type Group:
hi def link nasmType		Type
hi def link nasmStorage		Type
hi def link nasmStructure	Structure
hi def link nasmTypeError	Error

" Directive Group:
hi def link nasmConstant	Constant
hi def link nasmInstrModifier	Operator
hi def link nasmRepeat		Repeat
hi def link nasmStdDirective	PreProc
hi def link nasmFmtDirective	Keyword
hi def link nasmDirective	newTemplateColor

hi def link nasmWRT		Structure
hi def link nasmStorageModifier	Special
hi def link nasmWRTlocation	Special

" Register Group:
hi def link nasmCtrlRegister	Special
hi def link nasmDebugRegister	Debug
hi def link nasmTestRegister	Special
hi def link nasmRegisterError	Error
hi def link nasmMemRefError	Error

" Instruction Group:
hi def link nasmStdInstruction	Statement
hi def link nasmSysInstruction	Statement
hi def link nasmDbgInstruction	Debug
hi def link nasmFpuInstruction	Statement
hi def link nasmMmxInstruction	Statement
hi def link nasmSseInstruction	Statement
hi def link nasmNowInstruction	Statement
hi def link nasmAmdInstruction	Special
hi def link nasmCrxInstruction	Special
hi def link nasmUndInstruction	Todo
hi def link nasmInstructnError	Error

hi def link nasmBmiInstruction	Statement
hi def link nasmAvxInstruction	Statement
hi def link nasmAvx512Instruction nasmAvxInstruction


let b:current_syntax = 'nasm'

" vim:ts=8 sw=4
