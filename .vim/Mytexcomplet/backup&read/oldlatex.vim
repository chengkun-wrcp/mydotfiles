" function! MakeRefList()	"see line('w0')
	" write
	" let CurrentPos = getcurpos()
	" execute 'normal gg'
	" let Pos1 = searchpos('\label{','e',line("$")) " n:do not move the cursor
	" let Pos2 = searchpos('}','e',line("$")) " n:do not move the cursor
	" " searchdecl : search for the declaration
	" let g:LatexRefList = []
	" while Pos1[0]
	" 	let Line = getline(Pos1[0])
	" 	call add(g:LatexRefList,Line[Pos1[1]:Pos2[1]-2])
	" 	let Pos1 = searchpos('\label{','e',line("$")) 
	" 	let Pos2 = searchpos('}','e',line("$")) " n:do not move the cursor
	" endwhile
	" call setpos('.',CurrentPos)
	" normal zz
" endfun
" function! MakeCiteList()
	" let bbl = expand('%:r').'.bbl'
	" let g:LatexCiteList=[]
	" if !filereadable(bbl)
	" 	return 
	" endif
	" let bibitem = system('grep bibitem '.bbl)
	" if bibitem =~ 'bibitem'
	" 	for item in split(bibitem,"\n")
	" 		let i=0
	" 		while i < len(item)
	" 			if item[i] == '{'
	" 				let Start = i
	" 			elseif item[i] == '}'
	" 				let End = i
	" 			endif
	" 			let i = i+1
	" 		endwhile
	" 		call add(g:LatexCiteList,item[Start+1:End-1])
	" 	endfor
	" endif
	" return
" endfun
