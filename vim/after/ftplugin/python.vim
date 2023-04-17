" Override default python.vim
if exists("g:python_noexpandtab")
	set noexpandtab
endif
if exists("g:python_override_tabstop")
	let &tabstop=g:python_override_tabstop
endif
setlocal cinoptions+=(0
