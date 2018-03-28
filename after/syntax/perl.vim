" Perl highlighting for Dancer keywords
" Maintainer:   vim-perl <vim-perl@groups.google.com>
" Installation: Put into after/syntax/perl/dancer.vim

" XXX include guard

syntax match perlStatementProc	'\<\%(after\|any\|before\|before_template\|cookies\|cookie\|config\|content_type\|dance\|dancer_version\|debug\|engine\|error\)\>'
syntax match perlStatementProc	'\<\%(forward\|from_dumper\|from_json\|from_yaml\|from_xml\|get\|halt\|headers\|header\|push_header\|hook\|info\|layout\|logger\)\>'
syntax match perlStatementProc	'\<\%(load\|load_app\|mime\|params\|param\|pass\|patch\|path\|post\|prefix\|del\|options\|put\|redirect\|render_with_layout\|request\)\>'
syntax match perlStatementProc	'\<\%(send_error\|send_file\|set\|setting\|set_cookie\|session\|splat\|start\|status\|template\|to_dumper\|to_json\|to_yaml\|to_xml\)\>'
syntax match perlStatementProc	'\<\%(upload\|uri_for\|captures\|var\|vars\|warning\)\>'

syntax match perlConstant	'\<\%(true\|false\)'


hi def link perlConstant	Constant
