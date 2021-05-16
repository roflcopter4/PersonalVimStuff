" Vim syntax file
" Language: Parser Expression Grammars (PEG)
" Maintainer: Gianni Chiappetta
" Latest Revision: 2011-02-08

if exists("b:current_syntax")
  finish
endif

syntax include @goSyntax syntax/go.vim

syn cluster pegExpression	contains=pegNonTerminal,pegTerminal,pegGrouping,pegPrefix,pegRange,pegCapture,pegOrderedChoice,pegDot,pegMaybeTerminal,pegCodeBlock,pegDelimiter

syn match   pegRuleIdentifier   /^\h\w*\>/    nextgroup=pegLeftArrow,pegComment1 skipwhite skipnl skipempty
syn match   pegLeftArrow        "\%(<-\|←\)"  nextgroup=@pegExpression,pegComment2 contained skipwhite skipnl skipempty
syn match   pegPrefix           /[!&ϵ^]/      nextgroup=@pegExpression,pegComment2 contained skipwhite skipnl skipempty
syn match   pegOrderedChoice    "[/|]"        nextgroup=@pegExpression,pegComment2 contained skipwhite skipnl skipempty
syn match   pegSuffix		/[+\*?]/      nextgroup=@pegExpression,pegCodeBlock,pegComment3 contained skipwhite skipnl skipempty
syn match   pegSuffix       	/{\d\+,\d\+}/ nextgroup=@pegExpression,pegCodeBlock,pegComment3 contained skipwhite skipnl skipempty
syn match   pegSuffix       	/{\d\+}/      nextgroup=@pegExpression,pegCodeBlock,pegComment3 contained skipwhite skipnl skipempty
syn match   pegCapture		/[<>]/        nextgroup=@pegExpression,pegCodeBlock,pegComment3 contained skipwhite skipnl skipempty

syn region  pegGrouping         matchgroup=pegDelimiter start=/(/  end=/)/ nextgroup=pegSuffix,@pegExpression,pegCodeBlock,pegComment4 contains=@pegExpression skipwhite skipnl skipempty contained transparent
syn region  pegCodeBlock	matchgroup=pegDelimiter start=/{/  end=/}/ nextgroup=pegOrderedChoice,pegComment5,@pegExpression contains=@goSyntax contained keepend skipwhite skipnl skipempty transparent
syn region  pegTerminal         start=/"/  end=/"/  skip=/\%(\\\\\|[^\\]\)\@2<=\\"/  nextgroup=pegSuffix,@pegExpression,pegCodeBlock,pegComment4 skipwhite skipnl skipempty contained
syn region  pegTerminal         start=/'/  end=/'/  skip=/\%(\\\\\|[^\\]\)\@2<=\\'/  nextgroup=pegSuffix,@pegExpression,pegCodeBlock,pegComment4 skipwhite skipnl skipempty contained
syn region  pegRange            matchgroup=pegDelimiter start=/\[/ end=/\]/ skip=/\%(\\\\\|[^\\]\)\@2<=\\\]/ nextgroup=pegSuffix,@pegExpression,pegCodeBlock,pegComment4 contains=pegRangeValue,pegUnicode,pegSpecial skipwhite skipnl skipempty

syn match   pegNonTerminal      /\h\w*\>\%(\%(\s\|\n\|\r\)*<-\)\@!/ nextgroup=pegSuffix,@pegExpression,pegCodeBlock,pegComment4 skipwhite skipnl skipempty contained
syn match   pegMaybeTerminal    /[_A-Z][_A-Z0-9]*\>\%(\%(\s\|\n\|\r\)*<-\)\@!/ nextgroup=pegSuffix,@pegExpression,pegCodeBlock,pegComment4 skipwhite skipnl skipempty contained
syn match   pegDot		/\./                                nextgroup=pegSuffix,@pegExpression,pegCodeBlock,pegComment4 skipwhite skipnl skipempty contained

syn match   pegRangeValue       /\d\+-\d\+/ contained
syn match   pegRangeValue       /\a\+-\a\+/ contained
syn match   pegUnicode          /U+[A-F0-9]\{4,6}/ contained
syn match   pegSpecial          "\\\%(x\x\+\|\o\{1,3}\|.\|$\)" display contained
syn match   pegSpecial          "\\\%(u\x\{4}\|U\x\{8}\)" display contained

syn match   pegComment1         /#.*/ contains=pegTodo contained skipwhite skipnl skipempty nextgroup=pegLeftArrow,pegComment1
syn match   pegComment2         /#.*/ contains=pegTodo contained skipwhite skipnl skipempty nextgroup=@pegExpression,pegComment2
syn match   pegComment3         /#.*/ contains=pegTodo contained skipwhite skipnl skipempty nextgroup=@pegExpression,pegCodeBlock,pegComment3
syn match   pegComment4         /#.*/ contains=pegTodo contained skipwhite skipnl skipempty nextgroup=pegSuffix,@pegExpression,pegCodeBlock,pegComment4
syn match   pegComment5         /#.*/ contains=pegTodo contained skipwhite skipnl skipempty nextgroup=pegOrderedChoice,pegComment5
syn match   pegCommentTop       /#.*$/ contains=pegTodo
syn keyword pegTodo             TODO FIXME XXX NOTE contained

syntax region pegGoSyntax_Curly   start="^\s*\%(type\)\>.*{"               end="^}$" contains=@goSyntax
syntax region pegGoSyntax_Paren   start="^\s*\%(import\)\>\s*("            end="^)$" contains=@goSyntax
syntax region pegGoSyntax_OneLine start="^\s*\%(import\|type\|package\)\>" end="$"   contains=@goSyntax oneline


hi def link pegRuleIdentifier Identifier
hi def link pegNonTerminal    PreProc
hi def link pegMaybeTerminal  Type
hi def link pegTerminal       String

hi def link pegLeftArrow      Conditional
hi def link pegDelimiter      Delimiter
hi def link pegPrefix         Keyword
hi def link pegSuffix         Keyword
hi def link pegOrderedChoice  Conditional
hi def link pegDot            Keyword

hi def link pegCapture        mutedFunc
hi def link pegRangeValue     Number
hi def link pegUnicode        SpecialChar
hi def link pegSpecial        SpecialChar
" hi def link pegGroupDelimiter Keyword

hi def link pegComment1       pegCommentTop
hi def link pegComment2       pegCommentTop
hi def link pegComment3       pegCommentTop
hi def link pegComment4       pegCommentTop
hi def link pegComment5       pegCommentTop
hi def link pegCommentTop     Comment
hi def link pegTodo           Todo

syntax sync fromstart

let b:current_syntax = "peg"
