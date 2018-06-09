 " Quit when a (custom) syntax file was already loaded
if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim
let s:ft = matchstr(&filetype, '^\([^.]\)\+')


syntax region cppSpecialOperator matchgroup=Keyword start=/delete\[/ end=/\]/ transparent 


let b:current_syntax = 'test'
unlet s:ft
let &cpo = s:cpo_save
unlet s:cpo_save
