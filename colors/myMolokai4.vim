" Author: Tomas Restrepo <tomas@winterdom.com>
" Note: Based on the monokai theme for textmate by Wimer Hazenberg and
"       its darker variant by Hamish Stuart Macpherson
"
" Note: Extensively edited by RoflCopter4

highlight clear

if v:version > 580
    highlight clear
    if exists('syntax_on')
        syntax reset
    endif
endif
let g:colors_name='myMolokai4'

function! s:HL(group, guifg, guibg, guif)
    let l:histring = 'hi ' . a:group

    if a:guifg !=# ''
        let l:histring .= ' guifg= ' . a:guifg
    endif

    if a:guibg !=# ''
        let l:histring .= ' guibg= ' . a:guibg
    endif

    if a:guif !=# ''
        let l:histring .= ' gui= ' . a:guif
    endif

    execute l:histring
endfunction

" ---------------------------------------------------------------------
" Readable Color Definitions

let s:normal           = '#F8F8F2'
let s:lighter_bg       = '#232526'
let s:cursor           = '#F8F8F0'

let s:white_           = '#FFFFFF'
let s:black_           = '#000000'
let s:near_black_      = '#080808'
let s:red_             = '#FF0000'

let s:light_purple     = '#AE81FF'
let s:light_yellow     = '#E6DB74'
let s:bright_pink      = '#F92672'  
let s:debug_grey       = '#BCA3A3'
let s:cyan_            = '#66D9EF'
let s:lime_            = '#A6E22E'
let s:orange_          = '#FD971F'
let s:nova_deep_orange = '#FF7043'
let s:orange_red       = '#EF5939'
let s:dark_blue        = '#13354A'
let s:dark_magenta     = '#960050'
let s:very_dark_red    = '#1E0010'
let s:baby_blue        = '#7070F0'
let s:light_cyan       = '#70F0F0'
let s:salmon_          = '#EF5350'

let s:very_light_grey  = '#BCBCBC'
let s:light_grey       = '#8F8F8F'
let s:dark_grey        = '#465457'
let s:very_dark_grey   = '#455354'
let s:border_grey      = '#808080'
let s:diff_grey        = '#89807D'
let s:key_grey         = '#888A85'
let s:cursorline_grey  = '#293739'
let s:warning_grey     = '#333333'

let s:nova_light_green = '#66BB6A'
let s:palevioletred_   = '#D33682'
let s:newMagenta       = '#CD00CD'

let s:muted_yellow     = '#908B25'
let s:function_green   = '#16DB2A'
let s:new_yellow       = '#BBBD4F'

let s:resharper_beige        = '#E6D8AD'
let s:nova_yellow            = '#FFEE58'
let s:nova_amber             = '#FFCA28'
let s:nova_orange            = '#FFA726'
"let s:resharper_namespace    = '#E6D8AD'
let s:resharper_namespace    = '#ADD8E6'
let s:resharper_light_blue   = '#ADD8E6'
let s:resharper_light_purple = '#DDA0DD'  " Struct members
let s:lighter_pink           = '#E58CB9'
let s:nifty_pink             = '#E55CA1'
let s:idunno                 = '#F7A6DA'
let s:idunno2                = '#ed92c0'
let s:resharper_light_blue   = '#ADD8E6'
let s:darker_cyan            = '#39acc2'
let s:nova_cyan              = '#26C6DA'
let s:nova_light_blue        = '#29B6F6'
let s:nova_blue              = '#42A5F5'
let s:nova_teal              = '#26A69A'
let s:resharper_light_green  = '#90EE90'
let s:resharper_operator     = '#4EC9B0'
let s:MSVC_darker_green      = '#4EC94C'


" NOTE: comment_grey is NOT used at all, only left in for legacy.
"       shiney_grey is used for comments
let s:comment_grey     = '#878787'
let s:shiny_grey       = '#7E8E91'
let s:grey4            = '#658494'
let s:grey5            = '#B7BDC0' 
let s:grey6            = '#AEBBC5'
let s:grey7            = '#5F87AF'

let s:diff_brown       = '#4C4745'
let s:grey_brown       = '#403D3D'
let s:beige_           = '#C4BE89'


let s:none             = 'none'
let s:bold             = 'bold'
let s:italic           = 'italic'
let s:bold_italic      = 'italic,bold'
let s:reverse          = 'reverse'
let s:undercurl        = 'undercurl'
let s:underline        = 'underline'

let s:perlspecial      = s:beige_


if exists('g:myMolokai_BG')
    if g:myMolokai_BG ==# 'darker'
        let s:background = '#131515'
    elseif g:myMolokai_BG ==# 'custom'
        let s:background = g:myMolokai_CustomBG
    else
        let s:background = '#1B1D1E'
    endif
else
    let s:background     = '#1B1D1E'
endif


if exists('g:myMolokai_FG')
    if g:myMolokai_FG ==# 'other'
        let s:foreground = '#F8F8F2'
    elseif g:myMolokai_FG ==# 'custom'
        let s:foreground = g:myMolokai_CustomFG
    else
        let s:foreground = '#ECEFF1'
    endif
else
    let s:foreground     = '#ECEFF1'
endif


if exists('g:myMolokaiComment')
    if g:myMolokaiComment ==# 'shiny'
        let s:comment = s:shiny_grey
    elseif g:myMolokaiComment ==# 'comment_grey'
        let s:comment = s:comment_grey
    elseif g:myMolokaiComment ==# 'custom'
        let s:comment = g:myMolokaiComment_Custom
    else
        let s:comment = s:grey4
    endif
else
    let s:comment = s:grey4
endif


" ---------------------------------------------------------------------

"hi MatchParen      guifg= guibg=#FD971F gui=bold
"hi Comment guifg=chartreuse3 ctermfg=10

"call s:HL('Error',         s:diff_grey,        s:very_dark_red,   s:none)
"call s:HL('Operator',      s:bright_pink,      '',                s:bold)
"call s:HL('Operator',      s:debug_grey,       '',                s:bold)
"call s:HL('Operator',      s:key_grey,         '',                s:bold)
"call s:HL('Operator',      s:lime_,            '',                s:bold)
"call s:HL('Operator',      s:newMagenta,       '',                s:bold)
"call s:HL('Operator',      s:nova_blue,        '',                s:bold)
"call s:HL('Operator',      s:nova_blue,        '',                s:none)
"call s:HL('Operator',      s:nova_light_green, '',                s:none)
"call s:HL('Operator',      s:palevioletred_,   '',                s:bold)
"call s:HL('Operator',      s:red_,             '',                s:bold)
"call s:HL('PreCondit',     s:MSVC_Violet,      '',                s:none)
"call s:HL('PreCondit',     s:lime_,            '',                s:bold)
"call s:HL('PreProc',       s:MSVC_Violet,      '',                s:none)
"call s:HL('SpecialChar',   s:bright_pink,      '',                s:bold)
" call s:HL('Include',        s:lime_,            '',                s:none)

call s:HL('Boolean',        s:light_purple,     '',                s:bold)
call s:HL('Character',      s:light_yellow,     '',                s:none)
call s:HL('Comment',        s:comment,          '',                s:none)
call s:HL('Conditional',    s:bright_pink,      '',                s:bold)
call s:HL('Constant',       s:light_purple,     '',                s:bold)
call s:HL('Cursor',         s:black_,           s:cursor,          s:none)
call s:HL('CursorColumn',   '',                 s:cursorline_grey, s:none)
call s:HL('CursorLine',     '',                 s:cursorline_grey, s:none)
call s:HL('Debug',          s:debug_grey,       '',                s:bold)
call s:HL('Define',         s:cyan_,            '',                s:none)
call s:HL('Delimiter',      s:light_grey,       '',                s:none)
call s:HL('DiffAdd',        '',                 s:dark_blue,       s:none)
call s:HL('DiffChange',     s:diff_grey,        s:diff_brown,      s:none)
call s:HL('DiffDelete',     s:diff_grey,        s:salmon_,         s:none)
call s:HL('DiffText',       '',                 s:diff_brown,      s:bold_italic)
call s:HL('Directory',      s:lime_,            '',                s:bold)
call s:HL('Error',          s:normal,           s:salmon_,         s:none)
call s:HL('ErrorMsg',       s:bright_pink,      s:lighter_bg,      s:bold)
call s:HL('Exception',      s:lime_,            '',                s:bold)
call s:HL('Float',          s:light_purple,     '',                s:none)
call s:HL('FoldColumn',     s:dark_grey,        s:black_,          s:none)
call s:HL('Folded',         s:dark_grey,        s:black_,          s:none)
call s:HL('Identifier',     s:orange_,          '',                s:none)
call s:HL('Ignore',         s:border_grey,      'bg',              s:none)
call s:HL('IncSearch',      s:orange_,          s:black_,          s:none)
call s:HL('Include',        s:baby_blue,        '',                s:none)
call s:HL('Keyword',        s:bright_pink,      '',                s:bold)
call s:HL('Label',          s:light_yellow,     '',                s:none)
call s:HL('LineNr',         s:very_light_grey,  s:lighter_bg,      s:none)
call s:HL('Macro',          s:beige_,           '',                s:none)
call s:HL('MatchParen',     s:black_,           s:orange_,         s:none)
call s:HL('ModeMsg',        s:light_yellow,     '',                s:none)
call s:HL('MoreMsg',        s:light_yellow,     '',                s:none)
call s:HL('NonText',        s:very_light_grey,  s:lighter_bg,      s:none)
call s:HL('Normal',         s:foreground,       s:background,      s:none)
call s:HL('Number',         s:light_purple,     '',                s:none)
call s:HL('Operator',       s:bright_pink,      '',                s:none)
call s:HL('Pmenu',          s:cyan_,            s:black_,          s:none)
call s:HL('PmenuSbar',      '',                 s:near_black_,     s:none)
call s:HL('PmenuSel',       '',                 s:border_grey,     s:none)
call s:HL('PmenuThumb',     s:cyan_,            '',                s:none)
call s:HL('PreCondit',      s:beige_,           '',                s:none)
call s:HL('PreProc',        s:lime_,            '',                s:none)
" call s:HL('PreProc',        s:resharper_light_green,            '',                s:none)
call s:HL('Question',       s:cyan_,            '',                s:none)
call s:HL('Repeat',         s:bright_pink,      '',                s:bold)
call s:HL('Search',         s:black_,           s:beige_,          s:none)
call s:HL('SignColumn',     s:lime_,            s:lighter_bg,      s:none)

call s:HL('Special',        s:cyan_,            'bg',              s:none)
" call s:HL('Special',        s:resharper_light_green,            'bg',              s:none)

call s:HL('SpecialChar',    s:bright_pink,      '',                s:none)
call s:HL('SpecialComment', s:shiny_grey,       '',                s:none)

call s:HL('SpecialKey',     s:cyan_,            '',                s:none)
" call s:HL('SpecialKey',     s:resharper_light_green,            '',                s:none)

call s:HL('Statement',      s:bright_pink,      '',                s:bold)
call s:HL('StatusLine',     s:very_dark_grey,   'fg',              s:none)
call s:HL('StatusLineNC',   s:border_grey,      s:near_black_,     s:none)
call s:HL('StorageClass',   s:orange_,          '',                s:none)
call s:HL('String',         s:light_yellow,     '',                s:none)
call s:HL('Structure',      s:cyan_,            '',                s:bold)
call s:HL('Substitute',     s:orange_,          s:black_,          s:none)
call s:HL('Tag',            s:bright_pink,      '',                s:italic)
call s:HL('Title',          s:orange_red,       '',                s:none)
call s:HL('Todo',           s:white_,           'bg',              s:bold)
call s:HL('Type',           s:cyan_,            '',                s:none)
call s:HL('Typedef',        s:cyan_,            '',                s:none)
call s:HL('Underlined',     s:border_grey,      '',                s:underline)
call s:HL('VertSplit',      s:border_grey,      s:near_black_,     s:bold)
call s:HL('Visual',         '',                 s:grey_brown,      s:none)
call s:HL('VisualNOS',      '',                 s:grey_brown,      s:none)
call s:HL('WarningMsg',     s:white_,           s:warning_grey,    s:bold)
call s:HL('WildMenu',       s:cyan_,            s:black_,          s:none)
" call s:HL('c_preproc',      s:light_purple,     '',                s:none)
" call s:HL('c_preproc',      s:muted_yellow,     '',                s:none)
call s:HL('c_preproc',      s:baby_blue,     '',                s:none)

if has('spell')
    hi SpellBad    guisp=#FF0000  gui=undercurl
    hi SpellCap    guisp=#7070F0  gui=undercurl
    hi SpellLocal  guisp=#70F0F0  gui=undercurl
    hi SpellRare   guisp=#FFFFFF  gui=undercurl
endif

" NONSTANDARD
" call s:HL('mutedFunc',        '#c8c8c8',      '', s:none)
" call s:HL('mutedFunc',         '#e58cb9',       '', s:none)
"call s:HL('CFuncTag',        s:nova_light_green, '', s:none)
"call s:HL('CFuncTag',        s:nova_teal,        '', s:none)
"call s:HL('CMember',         '#c8c8c8',          '', s:none)
"call s:HL('CMember',         '#e58cb9',          '', s:none)
"call s:HL('CMember',         s:foreground,       '', s:bold)
"call s:HL('CMember',         s:palevioletred_,   '', s:none)
"call s:HL('Enum',            s:cyan_,            '', s:bold)
"call s:HL('Enum',            s:nova_blue,        '', s:bold)
"call s:HL('OperatorChars',   s:debug_grey,       '', s:bold)
" call s:HL('CMember',          '#e55ca1',          '', s:none)
" call s:HL('cMiscFuncs',       s:light_purple,     '', s:bold)
" call s:HL('cMiscFuncs',       s:orange_,     '', s:none)

" call s:HL('CFuncTag',         s:function_green,   '', s:none)

" call s:HL('Function',         s:MSVC_darker_green, '',                s:none)
call s:HL('Function',         s:lime_,             '', s:none)
call s:HL('CFuncTag',         s:MSVC_darker_green, '', s:none)
call s:HL('CMember',          s:grey5,             '', s:none)
call s:HL('BoldGrey',         s:grey5,             '', s:bold)

" call s:HL('Namespace',  s:resharper_beige, '', s:none)
" call s:HL('BNamespace', s:resharper_beige, '', s:bold)
call s:HL('Namespace',  s:resharper_light_blue, '', s:none)
call s:HL('BNamespace', s:resharper_light_blue, '', s:bold)
call s:HL('Method',     s:resharper_light_green, '', s:none)

" call s:HL('CFuncTag',         s:resharper_light_blue,   '', s:none)
" call s:HL('CMember',          s:resharper_light_purple, '', s:none)
" call s:HL('GlobalVarTag',     s:new_yellow,     '', s:none)
" call s:HL('GlobalVarTag',     s:resharper_light_blue,     '', s:none)
" call s:HL('GlobalVarTag',     s:nova_teal,     '', s:none)
call s:HL('GlobalVarTag',     s:muted_yellow,     '', s:none)
call s:HL('cSpecial',         s:light_cyan,       '', s:none)

call s:HL('C_Struct',         s:cyan_,            '', s:bold)
call s:HL('Enum',             s:nova_blue,        '', s:none)
" call s:HL('GlobalVarTag',     s:muted_yellow,     '', s:none)
call s:HL('LightPinkR',       s:bright_pink,      '', s:none)
call s:HL('NegationChar',     s:red_,             '', s:bold)
call s:HL('PerlSpecialChar',  s:bright_pink,      '', s:bold)
call s:HL('PerlSpecialChar2', s:orange_red,       '', s:bold)
call s:HL('PerlMulti',        s:cyan_,            '', s:bold)
call s:HL('PreProcB',         s:lime_,            '', s:bold)
call s:HL('cMiscFuncs',       s:orange_red,       '', s:bold)
call s:HL('cNumberPrefix',    s:nova_light_green, '', s:none)
call s:HL('cNumberSuffix',    s:nova_light_green, '', s:none)
call s:HL('mutedFunc',        s:grey5,            '', s:bold)
call s:HL('perlTypeSpec',     s:cyan_,            '', s:bold)
call s:HL('pythonDocstring',  s:comment,          '', s:none)

call s:HL('Bold', '', '', s:bold)
call s:HL('BoldRed', s:red_, '', s:bold)
call s:HL('DelimiterBold', s:light_grey, '', s:bold)

call s:HL('OverloadedOperator', s:resharper_operator, '', s:none)
call s:HL('OverloadedDecl', s:nova_amber, '', s:none)
" call s:HL('overloadedDecl', s:nifty_pink, '', s:none)

call s:HL('perlQuoteSE',      s:lime_,     '', s:bold)
call s:HL('perlMatchSE',      s:lime_,     '', s:bold)

call s:HL('CommaSemicolon',   '',        '',  s:bold)


call s:HL('NewClassColor',     s:resharper_light_purple, '', s:none)
call s:HL('NewTemplateColor',  s:resharper_light_purple, '', s:bold)
" call s:HL('NonTypeTemplParam', s:nova_light_green, '', s:none)
call s:HL('NonTypeTemplParam', s:muted_yellow, '', s:none)
" call s:HL('newTemplateColor', s:nifty_pink, '', s:bold)
" call s:HL('newTemplateColor', s:lighter_pink, '', s:bold)
call s:HL('boldOrange',       s:orange_,                '', s:bold)
" call s:HL('magentaIGuess',    s:lighter_pink,  '', s:none)
" call s:HL('magentaIGuess',    s:idunno2,  '', s:none)
" call s:HL('magentaIGuess',    s:darker_cyan,  '', s:none)
" call s:HL('magentaIGuess',    s:nova_amber,  '', s:none)
call s:HL('magentaIGuess',    s:resharper_light_purple, '', s:none)
" call s:HL('OperatorChars',    s:debug_grey,       '', s:bold)
" call s:HL('OperatorChars',    s:resharper_beige,       '', s:bold)
" call s:HL('OperatorChars',    s:white_,       '', s:bold)
" call s:HL('OperatorChars',    s:debug_grey,       '', s:bold)
call s:HL('DereferenceStar',  s:debug_grey, '', s:bold)
" call s:HL('DereferenceStar',  s:resharper_beige, '', s:bold)


call s:HL('ExperimentalColor01r', s:idunno, '', s:none)
call s:HL('ExperimentalColor01b', s:idunno, '', s:bold)
call s:HL('ExperimentalColor02r', s:idunno2, '', s:none)
call s:HL('ExperimentalColor02b', s:idunno2, '', s:bold)
call s:HL('ExperimentalColor03r', s:lighter_pink, '', s:none)
call s:HL('ExperimentalColor03b', s:lighter_pink, '', s:bold)

set background=dark
