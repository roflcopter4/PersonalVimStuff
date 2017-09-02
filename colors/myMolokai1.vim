" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
"
" Note: Based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant 
" by Hamish Stuart Macpherson
"

hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="myMolokai1"

fun! s:HL(group, guifg, guibg, gui)
    let histring = "hi " . a:group

    if a:guifg != ''
        let histring .= " guifg= " . a:guifg
    endif

    if a:guibg != ''
        let histring .= " guibg= " . a:guibg
    endif

    if a:gui != ''
        let histring .= " gui= " . a:gui
    endif

    execute histring
endfun

" ---------------------------------------------------------------------
" Readable Color Definitions

let s:normal           = "#F8F8F2"
"let s:background       = "#1B1D1E"
let s:background       = "#131515"
let s:lighter_bg       = "#232526"
let s:cursor           = "#F8F8F0"

let s:white_           = "#FFFFFF"
let s:black_           = "#000000"
let s:near_black_      = "#080808"
let s:red_             = "#FF0000"

let s:light_purple     = "#AE81FF"
let s:light_yellow     = "#E6DB74"
let s:bright_pink      = "#F92672"
let s:debug_grey       = "#BCA3A3"
let s:cyan_            = "#66D9EF"
let s:lime_            = "#A6E22E"
let s:orange_          = "#FD971F"
let s:orange_red       = "#ef5939"
let s:dark_blue        = "#13354A"
let s:dark_magenta     = "#960050"
let s:very_dark_red    = "#1E0010"
let s:baby_blue        = "#7070F0"
let s:light_cyan       = "#70F0F0"
let s:salmon_          = "#EF5350"

let s:very_light_grey  = "#BCBCBC"
let s:light_grey       = "#8F8F8F"
let s:dark_grey        = "#465457"
let s:very_dark_grey   = "#455354"
let s:border_grey      = "#808080"
let s:diff_grey        = "#89807D"
let s:key_grey         = "#888A85"
let s:cursorline_grey  = "#293739"
let s:warning_grey     = "#333333"

" NOTE: comment_grey is NOT used at all, only left in for legacy.
"       shiney_grey is used for comments
let s:comment_grey     = "#878787"
let s:shiny_grey       = "#7E8E91"

let s:diff_brown       = "#4C4745"
let s:grey_brown       = "#403D3D"
let s:beige_           = "#C4BE89"


let s:none             = "none"
let s:bold             = "bold"
let s:italic           = "italic"
let s:bold_italic      = "italic,bold"
let s:reverse          = "reverse"
let s:undercurl        = "undercurl"
let s:underline        = "underline"


" ---------------------------------------------------------------------

"hi MatchParen      guifg= guibg=#FD971F gui=bold
"hi Comment guifg=chartreuse3 ctermfg=10


call s:HL("Boolean"        , s:light_purple    , ''                , '')
call s:HL("Character"      , s:light_yellow    , ''                , '')
call s:HL("Number"         , s:light_purple    , ''                , '')
call s:HL("String"         , s:light_yellow    , ''                , '')
call s:HL("Conditional"    , s:bright_pink     , ''                , s:bold)
call s:HL("Constant"       , s:light_purple    , ''                , s:bold)
call s:HL("Cursor"         , s:black_          , s:cursor          , '')
call s:HL("Debug"          , s:debug_grey      , ''                , s:bold)
call s:HL("Define"         , s:cyan_           , ''                , '')
call s:HL("Delimiter"      , s:light_grey      , ''                , '')
call s:HL("DiffAdd"        , ''                , s:dark_blue       , '')
call s:HL("DiffChange"     , s:diff_grey       , s:diff_brown      , '')
call s:HL("DiffDelete"     , s:diff_grey       , s:salmon_         , '')
call s:HL("DiffText"       , ''                , s:diff_brown      , s:bold_italic)

call s:HL("Directory"      , s:lime_           , ''                , s:bold)
"call s:HL("Error"         , s:diff_grey       , s:very_dark_red   , '')
call s:HL("Error"          , s:normal          , s:salmon_         , '')
call s:HL("ErrorMsg"       , s:bright_pink     , s:lighter_bg      , s:bold)
call s:HL("Exception"      , s:lime_           , ''                , s:bold)
call s:HL("Float"          , s:light_purple    , ''                , '')
call s:HL("FoldColumn"     , s:dark_grey       , s:black_          , '')
call s:HL("Folded"         , s:dark_grey       , s:black_          , '')
call s:HL("Function"       , s:lime_           , ''                , '')
call s:HL("Identifier"     , s:orange_         , ''                , '')
call s:HL("Ignore"         , s:border_grey     , "bg"              , '')
"call s:HL("IncSearch"      , s:beige_          , s:black_          , '')
call s:HL("IncSearch"      , s:orange_         , s:black_          , '')

call s:HL("Keyword"        , s:bright_pink     , ''                , s:bold)
call s:HL("Label"          , s:light_yellow    , ''                , s:none)
call s:HL("Macro"          , s:beige_          , ''                , s:italic)

call s:HL("MatchParen"     , s:black_          , s:orange_         , '')

call s:HL("ModeMsg"        , s:light_yellow    , ''                , '')
call s:HL("MoreMsg"        , s:light_yellow    , ''                , '')
call s:HL("Operator"       , s:bright_pink     , ''                , '')

" complete menu
call s:HL("Pmenu"          , s:cyan_           , s:black_          , '')
call s:HL("PmenuSel"       , ''                , s:border_grey     , '')
call s:HL("PmenuSbar"      , ''                , s:near_black_     , '')
call s:HL("PmenuThumb"     , s:cyan_           , ''                , '')

call s:HL("PreCondit"      , s:lime_           , ''                , s:bold)
call s:HL("PreProc"        , s:lime_           , ''                , '')
call s:HL("Question"       , s:cyan_           , ''                , '')
call s:HL("Repeat"         , s:bright_pink     , ''                , s:bold)
"call s:HL("Search"         , s:white_          , s:very_dark_grey  , '')
call s:HL("Search"         , s:black_          , s:beige_          , '')
" marks column
call s:HL("SignColumn"     , s:lime_           , s:lighter_bg      , '')
call s:HL("SpecialChar"    , s:bright_pink     , ''                , s:bold)

call s:HL("SpecialComment" , s:shiny_grey      , ''                , '')
call s:HL("Comment"        , s:shiny_grey      , ''                , '')

"call s:HL("Special"        , s:cyan_           , "bg"              , s:italic)
"call s:HL("SpecialKey"     , s:cyan_           , ''                , s:italic)
call s:HL("Special"        , s:cyan_           , "bg"              , '')
call s:HL("SpecialKey"     , s:cyan_           , ''                , '')

call s:HL("Statement"      , s:bright_pink     , ''                , s:bold)
call s:HL("StatusLine"     , s:very_dark_grey  , "fg"              , '')
call s:HL("StatusLineNC"   , s:border_grey     , s:near_black_     , '')
"call s:HL("StorageClass"   , s:orange_         , ''                , s:italic)
call s:HL("StorageClass"   , s:orange_         , ''                , '')
call s:HL("Structure"      , s:cyan_           , ''                , '')
call s:HL("Tag"            , s:bright_pink     , ''                , s:italic)
call s:HL("Title"          , s:orange_red      , ''                , '')
call s:HL("Todo"           , s:white_          , "bg"              , s:bold)

call s:HL("Typedef"        , s:cyan_           , ''                , '')
call s:HL("Type"           , s:cyan_           , ''                , s:none)
call s:HL("Underlined"     , s:border_grey     , ''                , s:underline)

call s:HL("VertSplit"      , s:border_grey     , s:near_black_     , s:bold)
call s:HL("VisualNOS"      , ''                , s:grey_brown      , '')
call s:HL("Visual"         , ''                , s:grey_brown      , '')
call s:HL("WarningMsg"     , s:white_          , s:warning_grey    , s:bold)
call s:HL("WildMenu"       , s:cyan_           , s:black_          , '')

call s:HL("Normal"         , s:normal          , s:background      , '')
call s:HL("CursorLine"     , ''                , s:cursorline_grey , '')
call s:HL("CursorColumn"   , ''                , s:cursorline_grey , '')
call s:HL("LineNr"         , s:very_light_grey , s:lighter_bg      , '')
call s:HL("NonText"        , s:very_light_grey , s:lighter_bg      , '')

if has("spell")
    hi SpellBad    guisp=#FF0000  gui=undercurl
    hi SpellCap    guisp=#7070F0  gui=undercurl
    hi SpellLocal  guisp=#70F0F0  gui=undercurl
    hi SpellRare   guisp=#FFFFFF  gui=undercurl
endif



"
" Support for 256-color terminal
"
if &t_Co > 255 && 0
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

