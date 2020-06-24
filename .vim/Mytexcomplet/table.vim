" function! Table()
	if col('.')==6
		let s:BS = repeat("\<BS>",6)
	else
		let s:BS = repeat("\<BS>",5)
	endif
	let s:BS = s:BS."\r"

	echo "line number:"
	let s:M=getchar()
	let s:M -= 48
	echo "column number:"
	let s:N=getchar()
	let s:N -= 48

	let s:LLL=repeat('l',s:N)
	let s:ContentLine = repeat('& ',s:N-1).'\\'."\r"
	let s:Content = repeat(s:ContentLine,s:M)	" M行

	let s:Line1='\begin{table}[h]'."\r"
	let s:Line2=	'\caption{\label{tab:~}%'."\r"
	let s:Line3=		'~}'."\r"
	let s:Line4=	'\begin{ruledtabular}'."\r"
	let s:Line5=	'\begin{tabular}{'.s:LLL.'}'."\r"
	" s:Content
	let s:Line6=	'\end{tabular}'."\r"
	let s:Line7=	'\end{ruledtabular}'."\r"
	let s:Line8= '\end{table}'
	let s:CursorMoveup = "\<home>".repeat("\<up>",7+s:M)

	let g:StringOfSnippet =  s:BS.s:Line1.s:Line2.s:Line3.s:Line4.s:Line5.s:Content.s:Line6.s:Line7.s:Line8.s:CursorMoveup
	" return g:StringOfSnippet
" endfun
