" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
"
" Note: Based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant 
" by Hamish Stuart Macpherson
"
" Note: Extensively edited by roflcopter4.

hi clear

"set background=dark
if v:version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists('syntax_on')
        syntax reset
    endif
endif
let g:colors_name='myMolokai3'

fun! s:HL(group, guifg, guibg, gui)
    let l:histring = 'hi ' . a:group

    if a:guifg !=# ''
        let l:histring .= ' guifg= ' . a:guifg
    endif

    if a:guibg !=# ''
        let l:histring .= ' guibg= ' . a:guibg
    endif

    if a:gui !=# ''
        let l:histring .= ' gui= ' . a:gui
    endif

    execute l:histring
endfun

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
let s:orange_red       = '#ef5939'
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

let s:nova_teal        = '#26A69A'
let s:nova_light_green = '#66BB6A'
let s:palevioletred_   = '#d33682'
let s:nova_blue        = '#42A5F5'
let s:newMagenta       = '#CD00CD'

" NOTE: comment_grey is NOT used at all, only left in for legacy.
"       shiney_grey is used for comments
let s:comment_grey     = '#878787'
let s:shiny_grey       = '#7E8E91'
let s:grey4            = '#658494'
let s:gray5            = '#b7bdc0' 
let s:grey6            = '#aebbc5'

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
        let s:background       = '#131515'
    elseif g:myMolokai_BG ==# 'custom'
        let s:background       = g:myMolokai_CustomBG
    else
        let s:background       = '#1B1D1E'
    endif
else
    let s:background       = '#1B1D1E'
endif


if exists('g:myMolokai_FG')
    if g:myMolokai_FG ==# 'other'
        let s:foreground       = '#F8F8F2'
    elseif g:myMolokai_FG ==# 'custom'
        let s:foreground       = g:myMolokai_CustomFG
    else
        let s:foreground       = '#ECEFF1'
    endif
else
    let s:foreground       = '#ECEFF1'
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


call s:HL('Boolean'        , s:light_purple    , ''                , s:none)
call s:HL('Character'      , s:light_yellow    , ''                , s:none)
call s:HL('Number'         , s:light_purple    , ''                , s:none)
call s:HL('String'         , s:light_yellow    , ''                , s:none)
call s:HL('Conditional'    , s:bright_pink     , ''                , s:bold)
call s:HL('Constant'       , s:light_purple    , ''                , s:bold)
call s:HL('Cursor'         , s:black_          , s:cursor          , s:none)
call s:HL('Debug'          , s:debug_grey      , ''                , s:bold)
call s:HL('Define'         , s:cyan_           , ''                , s:none)
call s:HL('Delimiter'      , s:light_grey      , ''                , s:none)
call s:HL('DiffAdd'        , ''                , s:dark_blue       , s:none)
call s:HL('DiffChange'     , s:diff_grey       , s:diff_brown      , s:none)
call s:HL('DiffDelete'     , s:diff_grey       , s:salmon_         , s:none)
call s:HL('DiffText'       , ''                , s:diff_brown      , s:bold_italic)

call s:HL('Directory'      , s:lime_           , ''                , s:bold)
"call s:HL('Error'         , s:diff_grey       , s:very_dark_red   , s:none)
call s:HL('Error'          , s:normal          , s:salmon_         , s:none)
call s:HL('ErrorMsg'       , s:bright_pink     , s:lighter_bg      , s:bold)
call s:HL('Exception'      , s:lime_           , ''                , s:bold)
call s:HL('Float'          , s:light_purple    , ''                , s:none)
call s:HL('FoldColumn'     , s:dark_grey       , s:black_          , s:none)
call s:HL('Folded'         , s:dark_grey       , s:black_          , s:none)
call s:HL('Function'       , s:lime_           , ''                , s:none)
call s:HL('Identifier'     , s:orange_         , ''                , s:none)
call s:HL('Ignore'         , s:border_grey     , 'bg'              , s:none)
call s:HL('IncSearch'      , s:orange_         , s:black_          , s:none)

call s:HL('Keyword'        , s:bright_pink     , ''                , s:bold)
call s:HL('Label'          , s:light_yellow    , ''                , s:none)
call s:HL('Macro'          , s:beige_          , ''                , s:italic)

call s:HL('MatchParen'     , s:black_          , s:orange_         , s:none)

call s:HL('ModeMsg'        , s:light_yellow    , ''                , s:none)
call s:HL('MoreMsg'        , s:light_yellow    , ''                , s:none)

"call s:HL('Operator'       , s:bright_pink     , ''                , s:bold)
call s:HL('Operator'       , s:bright_pink     , ''                , s:none)
"call s:HL('Operator'       , s:nova_light_green, ''                , s:none)
"call s:HL('Operator'       , s:palevioletred_  , ''                , s:bold)
"call s:HL('Operator'       , s:nova_blue       , ''                , s:none)
"call s:HL('Operator'       , s:nova_blue       , ''                , s:bold)
"call s:HL('Operator'       , s:lime_           , ''                , s:bold)
"call s:HL('Operator'        , s:debug_grey      , ''                , s:bold)
"call s:HL('Operator'        , s:key_grey      , ''                , s:bold)
"call s:HL('Operator'       , s:red_            , ''                , s:bold)
"call s:HL('Operator'       , s:newMagenta            , ''                , s:bold)


" complete menu
call s:HL('Pmenu'          , s:cyan_           , s:black_          , s:none)
call s:HL('PmenuSel'       , ''                , s:border_grey     , s:none)
call s:HL('PmenuSbar'      , ''                , s:near_black_     , s:none)
call s:HL('PmenuThumb'     , s:cyan_           , ''                , s:none)

call s:HL('PreCondit'      , s:lime_           , ''                , s:bold)
call s:HL('PreProc'        , s:lime_           , ''                , s:none)
call s:HL('Question'       , s:cyan_           , ''                , s:none)
call s:HL('Repeat'         , s:bright_pink     , ''                , s:bold)
call s:HL('Search'         , s:black_          , s:beige_          , s:none)

" marks column
call s:HL('SignColumn'     , s:lime_           , s:lighter_bg      , s:none)
"call s:HL('SpecialChar'    , s:bright_pink     , ''                , s:bold)
call s:HL('SpecialChar'    , s:bright_pink     , ''                , s:none)

call s:HL('SpecialComment' , s:shiny_grey      , ''                , s:none)
call s:HL('Comment'        , s:comment         , ''                , s:none)

call s:HL('Special'        , s:cyan_           , 'bg'              , s:none)
call s:HL('SpecialKey'     , s:cyan_           , ''                , s:none)
call s:HL('Statement'      , s:bright_pink     , ''                , s:bold)
call s:HL('StatusLine'     , s:very_dark_grey  , 'fg'              , s:none)
call s:HL('StatusLineNC'   , s:border_grey     , s:near_black_     , s:none)
call s:HL('StorageClass'   , s:orange_         , ''                , s:none)
call s:HL('Structure'      , s:cyan_           , ''                , s:none)
call s:HL('Tag'            , s:bright_pink     , ''                , s:italic)
call s:HL('Title'          , s:orange_red      , ''                , s:none)
call s:HL('Todo'           , s:white_          , 'bg'              , s:bold)

call s:HL('Typedef'        , s:cyan_           , ''                , s:none)
call s:HL('Type'           , s:cyan_           , ''                , s:none)
call s:HL('Underlined'     , s:border_grey     , ''                , s:underline)

call s:HL('VertSplit'      , s:border_grey     , s:near_black_     , s:bold)
call s:HL('VisualNOS'      , ''                , s:grey_brown      , s:none)
call s:HL('Visual'         , ''                , s:grey_brown      , s:none)
call s:HL('WarningMsg'     , s:white_          , s:warning_grey    , s:bold)
call s:HL('WildMenu'       , s:cyan_           , s:black_          , s:none)

call s:HL('Normal'         , s:foreground      , s:background      , s:none)
call s:HL('CursorLine'     , ''                , s:cursorline_grey , s:none)
call s:HL('CursorColumn'   , ''                , s:cursorline_grey , s:none)
call s:HL('LineNr'         , s:very_light_grey , s:lighter_bg      , s:none)
call s:HL('NonText'        , s:very_light_grey , s:lighter_bg      , s:none)

if has('spell')
    hi SpellBad    guisp=#FF0000  gui=undercurl
    hi SpellCap    guisp=#7070F0  gui=undercurl
    hi SpellLocal  guisp=#70F0F0  gui=undercurl
    hi SpellRare   guisp=#FFFFFF  gui=undercurl
endif

" NONSTANDARD
call s:HL('LightPinkR', s:bright_pink, '', s:none)

call s:HL('NegationChar', s:red_, '', s:bold)
call s:HL('pythonDocstring', s:comment, '', s:none)

call s:HL('PerlSpecialChar',s:debug_grey, '', s:bold)
call s:HL('PerlSpecialChar2', s:debug_grey, '', s:bold)
call s:HL('perlTypeSpec', s:cyan_, '', s:bold)
call s:HL('cMiscFuncs', s:light_purple, '', s:bold)
"call s:HL('OperatorChars', s:debug_grey, '', s:bold)
call s:HL('OperatorChars', s:debug_grey, '', s:none)

"call s:HL('CFuncTag', s:nova_light_green, '', s:none)
call s:HL('CFuncTag', s:nova_teal, '', s:none)
"call s:HL('CMember', s:foreground, '', s:bold)
call s:HL('CMember', s:palevioletred_, '', s:none)
call s:HL('PreProcB', s:lime_, '', s:bold)
"call s:HL('Enum', s:cyan_, '', s:bold)
"call s:HL('Enum', s:nova_blue, '', s:bold)
call s:HL('Enum', s:nova_blue, '', s:none)


"
" Support for 256-color terminal
"
if &t_Co > 255 && !has('termguicolors')
    hi Boolean         ctermfg=135
    hi Character       ctermfg=144
    hi Number          ctermfg=135
    hi String          ctermfg=144
    hi Conditional     ctermfg=161               cterm=bold
    hi Constant        ctermfg=135               cterm=bold
    hi Cursor          ctermfg=16  ctermbg=253
    hi Debug           ctermfg=225               cterm=bold
    hi Define          ctermfg=81
    hi Delimiter       ctermfg=241

    hi DiffAdd                     ctermbg=24
    hi DiffChange      ctermfg=181 ctermbg=239
    hi DiffDelete      ctermfg=162 ctermbg=53
    hi DiffText                    ctermbg=102 cterm=bold

    hi Directory       ctermfg=118               cterm=bold
    hi Error           ctermfg=219 ctermbg=89
    hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
    hi Exception       ctermfg=118               cterm=bold
    hi Float           ctermfg=135
    hi FoldColumn      ctermfg=67  ctermbg=16
    hi Folded          ctermfg=67  ctermbg=16
    hi Function        ctermfg=118
    hi Identifier      ctermfg=208
    hi Ignore          ctermfg=244 ctermbg=232
    hi IncSearch       ctermfg=193 ctermbg=16

    hi Keyword         ctermfg=161               cterm=bold
    hi Label           ctermfg=229               cterm=none
    hi Macro           ctermfg=193
    hi SpecialKey      ctermfg=81

    hi MatchParen      ctermfg=16  ctermbg=208 cterm=bold
    hi ModeMsg         ctermfg=229
    hi MoreMsg         ctermfg=229
    hi Operator        ctermfg=161

    " complete menu
    hi Pmenu           ctermfg=81  ctermbg=16
    hi PmenuSel                    ctermbg=244
    hi PmenuSbar                   ctermbg=232
    hi PmenuThumb      ctermfg=81

    hi PreCondit       ctermfg=118               cterm=bold
    hi PreProc         ctermfg=118
    hi Question        ctermfg=81
    hi Repeat          ctermfg=161               cterm=bold
    hi Search          ctermfg=253 ctermbg=66

    " marks column
    hi SignColumn      ctermfg=118 ctermbg=235
    hi SpecialChar     ctermfg=161               cterm=bold
    "hi SpecialComment  ctermfg=245               cterm=bold
    hi Special         ctermfg=81  ctermbg=232
    hi SpecialKey      ctermfg=245

    " SCOM=245   COM=59
    hi SpecialComment  ctermfg=11
    hi Comment         ctermfg=244

    hi Statement       ctermfg=161               cterm=bold
    hi StatusLine      ctermfg=238 ctermbg=253
    hi StatusLineNC    ctermfg=244 ctermbg=232
    hi StorageClass    ctermfg=208
    hi Structure       ctermfg=81
    hi Tag             ctermfg=161
    hi Title           ctermfg=166
    hi Todo            ctermfg=231 ctermbg=232   cterm=bold

    hi Typedef         ctermfg=81
    hi Type            ctermfg=81                cterm=none
    hi Underlined      ctermfg=244               cterm=underline

    hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
    hi VisualNOS                   ctermbg=238
    hi Visual                      ctermbg=235
    hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
    hi WildMenu        ctermfg=81  ctermbg=16

    hi Normal          ctermfg=252 ctermbg=233
    "hi Comment         ctermfg=59
    hi CursorLine                  ctermbg=234   cterm=none
    hi CursorColumn                ctermbg=234
    hi LineNr          ctermfg=250 ctermbg=234
    hi NonText         ctermfg=250 ctermbg=234
end

set background=dark
