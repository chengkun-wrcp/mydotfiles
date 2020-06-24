" append ,setline 不能用
" if col('.')==3
" 	let s:BS = repeat("\<BS>",3)
" else
" 	let s:BS = repeat("\<BS>",2)
" endif
" let s:BS=s:BS."\r"

" let s:Line1='\begin{equation}\label{eq:~}'."\r"
" let s:Line2='\end{equation}'
" let g:StringOfSnippet = s:BS.s:Line1.s:Line2."\<home>\<up>"

let LINElist=readfile(expand('%:p:r').'.tex',"\n")
let i=0
let g:TexCursorMoveSequence={}
let CurrentPos=getpos('.')	"[0,line,col,0]

for line in LINElist
	let i=i+1
	let newline=''
	for item in split(line,'#')
		if matchstr(item,'^[0-9]')==""
			let newline=newline.item
		else "item is a number
			let col=len(newline)+1
			let g:TexCursorMoveSequence[item]=[0,i+CurrentPos[1],col,0]
			echo g:TexCursorMoveSequence
		endif
	endfor
	call append(line('.')+i-1,newline)
endfor
