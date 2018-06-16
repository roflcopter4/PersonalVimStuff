" Perl highlighting for Dancer keywords
" Maintainer:   vim-perl <vim-perl@groups.google.com>
" Installation: Put into after/syntax/perl/dancer.vim

" XXX include guard

syntax keyword perlStatementProc	after any before before_template cookies cookie config content_type dance dancer_version debug engine error
syntax keyword perlStatementProc	forward from_dumper from_json from_yaml from_xml get halt headers header push_header hook info layout logger
syntax keyword perlStatementProc	load load_app mime params param pass patch path post prefix del options put redirect render_with_layout request
syntax keyword perlStatementProc	send_error send_file set setting set_cookie session splat start status template to_dumper to_json to_yaml to_xml
syntax keyword perlStatementProc	upload uri_for captures var vars warning

syntax keyword perlConstant		true false


hi def link perlConstant	Constant
