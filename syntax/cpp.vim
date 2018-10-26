" Vim syntax file
" Language:	C++
" Current Maintainer:	vim-jp (https://github.com/vim-jp/vim-cpp)
" Previous Maintainer:	Ken Shan <ccshan@post.harvard.edu>
" Last Change:	2017 Jun 05

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
runtime! syntax/c.vim
unlet b:current_syntax

" C++ extensions
syn keyword cppStatement	new this friend using
syn keyword cppAccess		public protected private
syn keyword cppModifier		inline virtual explicit export
syn keyword cppType		bool wchar_t
syn keyword cppExceptions	throw try catch
syn keyword cppOperator		operator typeid
syn keyword cppOperator		and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"me=e-1
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn keyword cppStorageClass	mutable
syn keyword cppStructure	class typename template namespace
syn keyword cppBoolean		true false
syn keyword cppConstant		__cplusplus

" C++ 11 extensions
if !exists("cpp_no_cpp11")
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
  syn region cppRawString	matchgroup=cppRawStringDelimiter start=+\%(u8\|[uLU]\)\=R"\z([[:alnum:]_{}[\]#<>%:;.?*\+\-/\^&|~!=,"']\{,16}\)(+ end=+)\z1"+ contains=@Spell
endif

" C++ 14 extensions
" if !exists("cpp_no_cpp14")
"   syn case ignore
"   syn match cppNumber		display "\<0b[01]\('\=[01]\+\)*\(u\=l\{0,2}\|ll\=u\)\>"
"   syn match cppNumber		display "\<[1-9]\('\=\d\+\)*\(u\=l\{0,2}\|ll\=u\)\>" contains=cFloat
"   syn match cppNumber		display "\<0x\x\('\=\x\+\)*\(u\=l\{0,2}\|ll\=u\)\>"
"   syn case match
" endif

syn case ignore
syn match	cNumbers	display transparent "\<\d\|\.\d" contains=cNumber,cFloat,cOctalError,cOctal,cBinary,cBinaryError,cHexadecimal,cHexError,cNumberSuffix
syn match	cNumbersCom	display contained transparent "\<\d\|\.\d" contains=cNumber,cFloat,cOctal,cNumberSuffix
syn match	cNumber		display contained "\%('\=\d\+\)*[ul]\{0,3}\>" contains=cNumberSuffix
syn match	cOctal		display contained "0\o\+[ul]\{0,3}\>" contains=cOctalZero,cNumberSuffix
syn match	cOctalZero	display contained "\<0"
syn match	cFloat		display contained "\d\+f"
syn match	cFloat		display contained "\d\+\.\d*\%(e[-+]\=\d\+\)\=[fl]\=" contains=cNumberSuffix
syn match	cFloat		display contained "\.\d\+\%(e[-+]\=\d\+\)\=[fl]\=\>"
syn match	cFloat		display contained "\d\+e[-+]\=\d\+[fl]\=\>"
syn match	cHexadecimal	display contained "\<0x\%('\=\x\+\)*[ul]\{0,3}\>" contains=cHexPrefix,cNumberSuffix
syn match	cHexPrefix	display contained "\<0x"
syn case match

if !exists('c_no_c99')
  "hexadecimal floating point number, optional leading digits, with dot, with exponent
  syn match	cFloat		display contained "0x\x*\.\x\+p[-+]\=\d\+[fl]\=\>"
  "hexadecimal floating point number, with leading digits, optional dot, with exponent
  syn match	cFloat		display contained "0x\x\+\.\=p[-+]\=\d\+[fl]\=\>"
endif
if exists('c_gnu')
  syn match	cBinary		display contained "\<0b[01]\+\%(u\=l\{0,2}\|ll\=u\)\>" contains=cBinaryPrefix,cNumberSuffix
  " syn match	cBinaryError	"0b[01]+[2-9]\d*"
  syn match	cBinaryPrefix	display contained "\<0b"
endif

" flag an octal number with wrong digits
syn match	cOctalError	display contained "0\o*[89]\d*"
" syn match	cNumberSuffix	contained "\%(\x\+\|[01]\+\|\o\+\|\d\+\)\zs\%(u\=l\{0,2}\|ll\=u\)"
syn match	cNumberSuffix	display contained "\%(0x\x\+\|0b[01]\+\|0\o\+\|\d\+\)\@23<=[ul]\{1,3}"
" syn match	cNumberSuffix	contained "\x\zs\%(u\=l\{0,2}\|ll\=u\)\>"
syn case match

" The minimum and maximum operators in GNU C++
syn match cppMinMax "[<>]?"

" Additions
syntax keyword cppAuto		auto
syntax match cppDelete		"\<delete\%(\[\]\)\?"


" Default highlighting
highlight def link cppAccess			cppStatement
highlight def link cppCast			cppStatement
highlight def link cppExceptions		Exception
highlight def link cppOperator			Operator
highlight def link cppStatement			Statement
highlight def link cppModifier			StorageClass
highlight def link cppType			Type
highlight def link cppStorageClass		StorageClass
highlight def link cppStructure			Structure
highlight def link cppBoolean			Boolean
highlight def link cppConstant			Constant
highlight def link cppRawStringDelimiter	Delimiter
highlight def link cppRawString			String
highlight def link cppNumber			Number
" Additions
highlight def link cppAuto			C_Struct
" highlight def link cppAuto			Type
highlight def link cppDelete			Keyword

let b:current_syntax = "cpp"

" vim: ts=8 noexpandtab
