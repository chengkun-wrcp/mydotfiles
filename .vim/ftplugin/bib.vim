function! ReadBiB()
	" cd %:h
	normal G
	let s:Path = '~/Downloads/'
	for File in split(system('ls ~/Downloads/*.bib'))
		exec 'read '.File
		normal G
	endfor
	" exec '!rm ~/Downloads/*.bib'
	call system('rm ~/Downloads/*.bib')
endfun
