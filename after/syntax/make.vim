" Vim syntax file
" Language:	BSD Makefile
" Maintainer:	Zsolt Udvari <uzsolt@uzsolt.hu>
" URL:  https://svn.uzsolt.hu/homefiles/vimfiles/trunk/after/syntax/make.vim?view=markup
" Last Change:	$LastChangedDate$
" This is a simple extension to make.vim
" Basic syntax highlighting for Makefile of FreeBSD's ports system.

" some directives
syn match bmakePreCondit	"^\. *\%(if\>\|ifeq\>\|else\>\|elif\>\|endif\>\|ifneq\>\|ifdef\>\|ifndef\>\)"
syn match makeInclude		"^\. *include"
syn match makeStatement		"^\. *\%(for\|endfor\)"
syn match makeExport		"^\. *\%(export\|unexport\)\>"
syn match makeOverride		"^\. *MAKEOVERRIDES"
syn match makeSpecial		"\%(\%([+:!?]=\|=\|:\)\|||\|&&\)"
"syn match makeSpecialOp	"\%(\%([+:!?]=\|=\|:\)\|||\|&&\)"

" make targets
syn match makeSpecTarget	"^\.\%(SUFFIXES\|PHONY\|DEFAULT\|PRECIOUS\|IGNORE\|MAIN\|SILENT\|EXPORT_ALL_VARIABLES\|KEEP_STATE\|LIBPATTERNS\|NOTPARALLEL\|DELETE_ON_ERROR\|INTERMEDIATE\|POSIX\|SECONDARY\)\>"
syn match makeSpecThingy	"\.WAIT"
syn match makeImplicit		"^\.[A-Za-z0-9_./\t -]\+\s*:$"me=e-1 nextgroup=makeSource
syn match makeImplicit		"^\.[A-Za-z0-9_./\t -]\+\s*:[^=]"me=e-2 nextgroup=makeSource

syn region makeTarget   transparent matchgroup=makeTarget start="^[~A-Za-z0-9_/${}()%-][A-Za-z0-9_/\t ${}()%-]*:\{1,2}[^:=]"rs=e-1 end=";"re=e-1,me=e-1 end="[^\\]$" keepend contains=makeIdent,makeSpecTarget,makeNextLine,makeComment,makeSpecTarget skipnl nextGroup=makeCommands
syn match makeTarget		"^[~A-Za-z0-9_/${}()%*@-][A-Za-z0-9_/\t ${}()%*@-]*::\=\s*$" contains=makeIdent,makeSpecTarget,makeComment,makeSpecThingy skipnl nextgroup=makeCommands,makeCommandError

syn match makePortsIdent  "PORTNAME\|PORTVERSION\|DISTVERSION\|PORTREVISION\|PORTEPOCH"
syn match makePortsIdent  "CATEGORIES\|MASTER_SITES\|DISTNAME\|MAINTAINER"
syn match makePortsIdent  "COMMENT\|LICENSE_FILE\|LICENSE"
syn match makePortsIdent  "BUILD_DEPENDS\|LIB_DEPENDS\|RUN_DEPENDS"

syn match makePortsBool "\<\%(yes\|no\)\>"

syn match makePortsUseIdent "\%(LD\|C\%(\|PP\)\)FLAGS"
syn match makePortsUseIdent "GNU_CONFIGURE\|CONFIGURE_ARGS"
syn match makePortsUseIdent "USES\|USE_\(GNOME\|RC_SUBR\)"
syn match makePortsUseIdent ".*_USE\|.*USE_OFF"
syn match makePortsUseIdent ".*_USES\|.*_LDFLAGS"
syn match makePortsUseIdent ".*_\(BUILD\|LIB\|RUN\)_DEPENDS"
syn match makePortsUseIdent ".*_CONFIGURE_\(ENABLE\|WITH\)"
syn match makePortsUseIdent ".*_CMAKE_\(ON\|OFF\)"
syn match makePortsUseIdent ".*_MESON_\(TRUE\|FALSE\|YES\|NO\|ON\|OFF\)"

syn region makePortsMacros start="\$(" skip="\\)\|\\\\" end=")" contains=makePortsMacros
syn region makePortsMacros start="\${" skip="\\}\|\\\\" end="}" contains=makePortsMacros
syn match makePortsMacros "INSTALL_PROGRAM"

syn match makePortsOptions "OPTIONS_\%(\%(GROUP\|MULTI\|RADIO\)_[A-Z0-9]*\|\(GROUP\|MULTI\|RADIO\|DEFINE\|DEFAULT\)\)"
syn match makePortsOptions ".*_DESC"

syn match makePortsError "BROKEN_.*\|FORBIDDEN_.*\|IGNORE_.*\|BROKEN\|FORBIDDEN\|IGNORE\|ONLY_FOR_ARCHS\|NOT_FOR_ARCHS"

hi! def link makeTarget  SpecialKey

highlight def link bmakePreCondit Conditional
hi! def link makePortsIdent     Label
hi! def link makePortsUseIdent  Type
hi! def link makePortsMacros    Macro
hi! def link makePortsOptions   Underlined
hi! def link makePortsError     Error
hi! def link makePortsBool      Boolean
"hi! def link makeSpecialOp      Operator
hi! def link makeSpecThingy     Operator
