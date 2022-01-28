" Vim syntax file
" Language:	C++
" Current Maintainer:	vim-jp (https://github.com/vim-jp/vim-cpp)
" Previous Maintainer:	Ken Shan <ccshan@post.harvard.edu>
" Last Change:	2017 Jun 05
" Last Change:	2021 Jan 12

" quit when a syntax file was already loaded
if exists('b:current_syntax')
  finish
endif

" inform C syntax that the file was included from cpp.vim
let b:filetype_in_cpp_family = 1

" Read the C syntax to start with
runtime! syntax/c.vim
unlet b:current_syntax

syntax match cppInlineNamespace /\<inline\>\ze\s\+namespace/
syntax match cppModifier /\<inline\>\%(\s\+namespace\)\@!/

" C++ extensions
syn keyword cppStatement	new this friend using
syn keyword cppAccess		public protected private
syn keyword cppModifier		virtual explicit export
syn keyword cppType		bool wchar_t
syn keyword cppExceptions	throw try catch
syn keyword cppOperator		operator typeid
syn keyword cppOperator		and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"me=e-1
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn keyword cppStorageClass	mutable
syn keyword cppStructure	class typename
syn keyword cppStatement	template namespace
syn keyword cppBoolean		true false
syn keyword cppConstant		__cplusplus

" C++ 11 extensions
if !exists('cpp_no_cpp11')
  syn keyword cppModifier	override final
  syn keyword cppType		nullptr_t
  syn keyword cppExceptions	noexcept
  syn keyword cppStorageClass	constexpr decltype thread_local
  syn keyword cppConstant	nullptr
  syn keyword cppConstant	ATOMIC_FLAG_INIT ATOMIC_VAR_INIT
  syn keyword cppConstant	ATOMIC_BOOL_LOCK_FREE ATOMIC_CHAR_LOCK_FREE
  syn keyword cppConstant	ATOMIC_CHAR16_T_LOCK_FREE ATOMIC_CHAR32_T_LOCK_FREE
  syn keyword cppConstant	ATOMIC_WCHAR_T_LOCK_FREE ATOMIC_SHORT_LOCK_FREE
  syn keyword cppConstant	ATOMIC_INT_LOCK_FREE ATOMIC_LONG_LOCK_FREE
  syn keyword cppConstant	ATOMIC_LLONG_LOCK_FREE ATOMIC_POINTER_LOCK_FREE
  syn region cppRawString	matchgroup=cppRawStringDelimiter start=+\%(u8\|[uLU]\)\=R"\z([[:alnum:]_{}[\]#<>%:;.?*\+\-/\^&|~!=,"']\{,16}\)(+ end=+)\z1"\(sv\|s\|_[_a-zA-Z][_a-zA-Z0-9]*\)\=+ contains=@Spell
  syn match cppCast		"\<\(const\|static\|dynamic\)_pointer_cast\s*<"me=e-1
  syn match cppCast		"\<\(const\|static\|dynamic\)_pointer_cast\s*$"
endif

" C++ 14 extensions
if !exists('cpp_no_cpp14')
  " syn case ignore
  " syn match cppNumber		display "\<0b[01]\('\=[01]\+\)*\(u\=l\{0,2}\|ll\=u\)\>"
  " syn match cppNumber		display "\<[1-9]\('\=\d\+\)*\(u\=l\{0,2}\|ll\=u\)\>" contains=cFloat
  " syn match cppNumber		display "\<0x\x\('\=\x\+\)*\(u\=l\{0,2}\|ll\=u\)\>"
  " syn case match

  " syn match cppNumbers		display transparent "\<\d\|\.\d" contains=cppNumber,cppFloat

  " syn match cppNumber		display contained "\<0\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
  " syn match cppNumber		display contained "\<[1-9]\%('\=\d\+\)*\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
  " syn match cppNumber		display contained "\<0\o\+\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
  " syn match cppNumber		display contained "\<0b[01]\%('\=[01]\+\)*\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
  " syn match cppNumber		display contained "\<0x\x\%('\=\x\+\)*\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"

  " syn match cppFloat		display contained "\<\d\+\.\d*\%(e[-+]\=\d\+\)\=\%([FfLl]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
  " syn match cppFloat		display contained "\<\.\d\+\%(e[-+]\=\d\+\)\=\%([FfLl]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
  " syn match cppFloat		display contained "\<\d\+e[-+]\=\d\+\%([FfLl]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"

  syn region cppString		start=+\%(u8\|[uUL]\)\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"\%(sv\|s\|_\i*\)\=+ end='$' contains=cSpecial,cFormat,@Spell
endif

" C++ 17 extensions
if !exists('cpp_no_cpp17')
  syn match cppCast		"\<reinterpret_pointer_cast\s*<"me=e-1
  syn match cppCast		"\<reinterpret_pointer_cast\s*$"

  syn match cppCast		"\<reinterpret_pointer_cast\s*<"me=e-1
  syn match cppCast		"\<reinterpret_pointer_cast\s*$"
  " syn match cppFloat		display contained "\<0x\x*\.\x\+p[-+]\=\d\+\%([FfLl]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
  " syn match cppFloat		display contained "\<0x\x\+\.\=p[-+]\=\d\+\%([FfLl]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"

  " TODO: push this up to c.vim if/when supported in C23
  syn match cppCharacter	"u8'[^\\]'"
  syn match cppCharacter	"u8'[^']*'" contains=cSpecial
  if exists("c_gnu")
    syn match cppSpecialError	  "u8'\\[^'\"?\\abefnrtv]'"
    syn match cppSpecialCharacter "u8'\\['\"?\\abefnrtv]'"
  else
    syn match cppSpecialError	  "u8'\\[^'\"?\\abfnrtv]'"
    syn match cppSpecialCharacter "u8'\\['\"?\\abfnrtv]'"
  endif
  syn match cppSpecialCharacter display "u8'\\\o\{1,3}'"
  syn match cppSpecialCharacter display "u8'\\x\x\+'"
endif

" C++ 20 extensions
if !exists('cpp_no_cpp20')
  syn keyword cppStatement	co_await co_return co_yield requires
  syn keyword cppStorageClass	consteval constinit
  syn keyword cppStructure	concept
  syn keyword cppType		char8_t
  syn keyword cppModule		import module export

  " syn match cppNumber		display contained "\<0\%(y\|d\)\>"
  " syn match cppNumber		display contained "\<[1-9]\%('\=\d\+\)*\%(y\|d\)\>"
  " syn match cppNumber		display contained "\<0\o\+\%(y\|d\)\>"
  " syn match cppNumber		display contained "\<0b[01]\('\=[01]\+\)*\%(y\|d\)\>"
  " syn match cppNumber		display contained "\<0x\x\%('\=\x\+\)*\%(y\|d\)\>"
  syn keyword cppStatement	co_await co_return co_yield requires
  syn keyword cppStorageClass	consteval constinit
  syn keyword cppStructure	concept
  syn keyword cppType		char8_t
  syn keyword cppModule		import module export
endif

" The minimum and maximum operators in GNU C++
syn match cppMinMax "[<>]?"

" syn case ignore
" syn match	cNumbers	display transparent "\<\d\|\.\d" contains=cNumber,cFloat,cOctalError,cOctal,cBinary,cBinaryError,cHexadecimal,cHexError,cNumberSuffix
" syn match	cNumbersCom	display contained transparent "\<\d\|\.\d" contains=cNumber,cFloat,cOctal,cNumberSuffix
" syn match	cNumber		display contained "\%('\=\d\+\)*[ul]\{0,3}\>" contains=cNumberSuffix
" syn match	cOctal		display contained "0\o\+[ul]\{0,3}\>" contains=cOctalZero,cNumberSuffix
" syn match	cOctalZero	display contained "\<0"
" syn match	cFloat		display contained "\d\+f"
" syn match	cFloat		display contained "\d\+\.\d*\%(e[-+]\=\d\+\)\=[fl]\=" contains=cNumberSuffix
" syn match	cFloat		display contained "\.\d\+\%(e[-+]\=\d\+\)\=[fl]\=\>"
" syn match	cFloat		display contained "\d\+e[-+]\=\d\+[fl]\=\>"
" syn match	cHexadecimal	display contained "\<0x\%('\=\x\+\)*[ul]\{0,3}\>" contains=cHexPrefix,cNumberSuffix
" syn match	cHexPrefix	display contained "\<0x"
" 
" if !exists('c_no_c99')
"   "hexadecimal floating point number, optional leading digits, with dot, with exponent
"   syn match	cFloat		display contained "0x\x*\.\x\+p[-+]\=\d\+[fl]\=\>"
"   "hexadecimal floating point number, with leading digits, optional dot, with exponent
"   syn match	cFloat		display contained "0x\x\+\.\=p[-+]\=\d\+[fl]\=\>"
" endif
" if exists('c_gnu')
"   syn match	cBinary		display contained "\<0b[01]\+\%(u\=l\{0,2}\|ll\=u\)\>" contains=cBinaryPrefix,cNumberSuffix
"   syn match	cBinaryPrefix	display contained "\<0b"
" endif
" 
" " flag an octal number with wrong digits
" syn match	cOctalError	display contained "0\o*[89]\d*"
" syn match	cNumberSuffix	display contained "\%(0x\x\+\|0b[01]\+\|0\o\+\|\d\+\)\@23<=[ul]\{1,3}"
" syn case match

  " syn match cppNumbers		display transparent "\<\d\|\.\d" contains=cppNumber,cppFloat,cOctal,cBinary,cHexadecimal,cppNumberSuffix,cppFloatSuffix

" syn match cppNumbers		display transparent "\<\%(0x\)\=\%(\x\+\.\|\.\x\+\)[fL]\=\>" contains=cppFloat

" syn match cppNumbers		display transparent "\<\x\|\.\x" contains=cppPrefixDecimal,cppPrefixOctal,cppPrefixBinary,cppPrefixHexadecimal,cppNumberDecimal,cppNumberOctal,cppNumberBinary,cppNumberHexadecimal,cppFloat,cppNumberSuffix,cppFloatSuffix
"syn match cppNumbers		display transparent "\<\%(\%(\x\+\%(\.\x*\)\=\)\|\.\x\+\|\)" contains=cppPrefixDecimal,cppPrefixOctal,cppPrefixBinary,cppPrefixHexadecimal,cppNumberDecimal,cppNumberOctal,cppNumberBinary,cppNumberHexadecimal,cppFloat,cppNumberSuffix,cppFloatSuffix

"exe 'syn match cppNumberZero		display "\<0"' . '     nextgroup=cppNumberSuffix'

"syn match cppNumberDecimal			"\<[1-9]\%('\=\d\+\)*"		nextgroup=cppNumberSuffix
"syn match cppNumberOctal			"\<0\o\+"			contains=cppPrefixOctal nextgroup=cppNumberSuffix
"syn match cppNumberBinary			"\<0b[01]\%('\=[01]\+\)*"	contains=cppPrefixBinary nextgroup=cppNumberSuffix
"syn match cppNumberHexadecimal			"\<0x\x\%('\=\x\+\)*"		contains=cppPrefixHexadecimal nextgroup=cppNumberSuffix
"syn match cppFloat		contained	"\<\d\+\.\d*\%(e[-+]\=\d\+\)\="	contains=cppFloatExp nextgroup=cppFloatSuffix 
"syn match cppFloat		contained	"\<\.\d\+\%(e[-+]\=\d\+\)\="	contains=cppFloatExp nextgroup=cppFloatSuffix 
"syn match cppFloat		contained	"\<\d\+e[-+]\=\d\+"		contains=cppFloatExp nextgroup=cppFloatSuffix
"syn match cppFloat		contained	"\<0x\x*\.\x\+p[-+]\=\d\+"	contains=cppPrefixHexadecimal,cppFloatExp nextgroup=cppFloatSuffix
"syn match cppFloat		contained	"\<0x\x\+\.\=p[-+]\=\d\+"	contains=cppPrefixHexadecimal,cppFloatExp nextgroup=cppFloatSuffix


syn match cppNumberZero		display			"\<\.\@1<!0\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|h\|min\|[mun]\=s\|y\|d\|_\i*\)\=\>"				contains=cppNumberSuffix
syn match cppNumberDecimal	display			"\<\.\@1<!\%([1-9]\%('\=\d\+\)*\)\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|h\|min\|[mun]\=s\|y\|d\|_\i*\)\=\>"	contains=cppNumberSuffix
syn match cppNumberOctal	display			"\<\.\@1<!\%(0\o\+\)\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|h\|min\|[mun]\=s\|y\|d\|_\i*\)\=\>\>"			contains=cppPrefixOctal,cppNumberSuffix
syn match cppNumberBinary	display			"\<\.\@1<!\%(0[bB][01]\%('\=[01]\+\)*\)\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|h\|min\|[mun]\=s\|y\|d\|_\i*\)\=\>"	contains=cppPrefixBinary,cppNumberSuffix
syn match cppNumberHexadecimal	display			"\<\.\@1<!\%(0[xX]\x\%('\=\x\+\)*\)\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|h\|min\|[mun]\=s\|y\|d\|_\i*\)\=\>"	contains=cppPrefixHexadecimal,cppNumberSuffix

syn match cppPrefixBinary	display contained	"\<0[bB]"
syn match cppPrefixHexadecimal	display contained	"\<0[xX]"
syn match cppPrefixOctal	display contained	"\<0\ze\o\+"

syn match cppFloat		display			"\<\%(\d\+\.\d*\%([eE][-+]\=\d\+\)\=\)\%([FfLl][iI]\=\|[iI][FfLl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"	contains=cppFloatExp,cppFloatSuffix 
syn match cppFloat		display			"\<\%(\d\+[eE][-+]\=\d\+\)\%([FfLl][iI]\=\|[iI][FfLl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"		contains=cppFloatExp,cppFloatSuffix
syn match cppFloat		display			"\<\%(0[xX]\x*\.\x\+[pP][-+]\=\d\+\)\%([FfLl][iI]\=\|[iI][FfLl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"	contains=cppPrefixHexadecimal,cppFloatExp,cppFloatSuffix
syn match cppFloat		display			"\<\%(0[xX]\x\+\.\=[pP][-+]\=\d\+\)\%([FfLl][iI]\=\|[iI][FfLl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"	contains=cppPrefixHexadecimal,cppFloatExp,cppFloatSuffix
syn match cppFloat		display			"\%(\.\d\+\)\%([eE][-+]\=\d\+\)\=\%([FfLl][iI]\=\|[iI][FfLl]\=\|h\|min\|s\|ms\|us\|ns\)\=\>"		contains=cppFloatExp,cppFloatSuffix 

syn match cppNumberSuffix	display contained	+\%([Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|h\|min\|[mun]\=s\|y\|d\|_\i*\)\>+
syn match cppFloatSuffix	display contained	+\%([FfLl][iI]\=\|[iI][FfLl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\>+
syn match cppFloatExp		display contained	"[eEpP]"


syn cluster cppNumberSuffixes contains=cppNumberSuffix,cppFloatSuffix,cppFloatExp


" The minimum and maximum operators in GNU C++
syn match cppMinMax "[<>]?"

" Additions
syntax keyword cppAuto		auto
syntax match cppDelete		"\<delete\%(\[]\|\>\)"


highlight def link cppInlineNamespace statement

" Default highlighting
highlight def link cppAccess			cppStatement
highlight def link cppBoolean			Boolean
highlight def link cppCast			cppStatement
highlight def link cppCharacter			cCharacter
highlight def link cppConstant			Constant
highlight def link cppExceptions		Exception
" highlight def link cppFloat			Number
highlight def link cppModifier			StorageClass
highlight def link cppModule			Include
highlight def link cppModule			Include
" highlight def link cppNumber			Number
highlight def link cppOperator			Operator
highlight def link cppRawString			String
highlight def link cppRawStringDelimiter	Delimiter
highlight def link cppSpecialCharacter		cSpecialCharacter
highlight def link cppSpecialError		cSpecialError
highlight def link cppStatement			Statement
highlight def link cppStorageClass		StorageClass
highlight def link cppString			String
highlight def link cppStructure			Structure
highlight def link cppType			Type

highlight def link cppFloat			Number
highlight def link cppFloat2			Number
highlight def link cppNumberZero		Number
highlight def link cppNumberDecimal		Number
highlight def link cppNumberOctal		Number
highlight def link cppNumberBinary		Number
highlight def link cppNumberHexadecimal		Number

highlight def link cppPrefixOctal		cNumberPrefix
highlight def link cppPrefixBinary		cNumberPrefix
highlight def link cppPrefixHexadecimal		cNumberPrefix
highlight def link cppNumberSuffix		cNumberPrefix
highlight def link cppFloatSuffix		cNumberPrefix
highlight def link cppFloatExp			cNumberPrefix
"cppPrefixFloatSuffix


" Additions
highlight def link cppAuto			C_Struct
highlight def link cppDelete			Keyword

let b:current_syntax = "cpp"

" vim: ts=8 noexpandtab
