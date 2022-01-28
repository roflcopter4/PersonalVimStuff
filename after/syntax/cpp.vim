syntax keyword smart_pointers unique_ptr shared_ptr weak_ptr
syntax keyword cppConstant __VA_OPT__

syntax match cppInlineNamespace +\<inline\>\%( namespace\)\@=+

highlight! link smart_pointers cMiscFuncs

" syntax match cppDelete		"\<delete\[]"
" highlight! link cppDelete	Keyword
