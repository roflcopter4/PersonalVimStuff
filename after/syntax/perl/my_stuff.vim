" Perl highlighting for Dancer keywords
" Maintainer:   vim-perl <vim-perl@groups.google.com>
" Installation: Put into after/syntax/perl/dancer.vim

" XXX include guard

"syntax keyword perlStatementProc		after any before before_template cookies cookie config content_type dance dancer_version debug engine error
"syntax keyword perlStatementProc		forward from_dumper from_json from_yaml from_xml get halt headers header push_header hook info layout logger
"syntax keyword perlStatementProc		load load_app mime params param pass patch path post prefix del options put redirect render_with_layout request
"syntax keyword perlStatementProc		upload uri_for captures var vars warning
"syntax keyword perlStatementProc		send_error send_file set setting set_cookie session splat start status template to_dumper to_json to_yaml to_xml
syntax keyword perlConstant			true false
syntax keyword perlStatementStorageExtra	new struct
syntax keyword perlStatementFunction		getcwd looks_like_number which
syntax keyword perlStatementFunction		shell_quote tempdir cleanup 
syntax keyword perlStatementFunction		mv cp dircopy clone GetOptions
syntax keyword perlStatementFunction		abs2rel canonpath catfile catdir rel2abs splitpath 
syntax keyword perlStdioFiles			STDIN STDOUT STDERR

hi def link perlStatementStorageExtra	perlType
hi def link perlStatementStorage	perlTypeSpec

" hi link perlCaptureGroup		SpecialChar
" hi link perlNonCaptureGroup		SpecialChar
hi link perlPatSep			SpecialChar
hi link perlMultiModifiers		perlMulti
hi link perlSpecialString		mutedFunc
hi link MatchGroupStartEnd		PerlSpecialChar
hi link MatchGroupStartEnd2		PerlSpecialChar2

hi link perlStatementStorage		Structure
hi link perlModuleFunctions		perlStatement

hi def link perlStatementFunction	mutedFunc
hi link perlStatementProc		mutedFunc
hi link perlStatementFiles		mutedFunc
" hi link perlStatementScalar		mutedFunc
hi link perlStatementIOfunc		mutedFunc
hi link perlStatementIPC		mutedFunc
hi link perlStatementNetwork		mutedFunc
hi link perlStatementPword		mutedFunc
hi link perlStatementTime		mutedFunc
hi link perlStatementFiledesc		mutedFunc
hi def link perlStdioFiles		operator

" hi link perlConstant			Constant
