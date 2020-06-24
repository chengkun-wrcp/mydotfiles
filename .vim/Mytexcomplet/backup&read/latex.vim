" AutoCMDGroup:
augroup LatexOpen
	autocmd!
	autocmd BufRead *.tex exec ':call MakeCiteList()|call MakeRefList()'
augroup END
" Some Simple Stuffs:
" onoremap<buffer> se :<c-u>execute "normal! ?\\<section\rf{vi{"<cr>
" onoremap<buffer> su :<c-u>execute "normal! ?\\<subsection\rf{vi{"<cr>
onoremap<buffer> in :<c-u>normal! f{vi{<cr>
vnoremap<buffer> in :<c-u>normal! f{vi{<cr>
let g:AutoPairs['$']='$'
nnoremap<buffer> <Leader>o gf
inoremap<buffer> \[ \[  \]<left><left><left>
" autocmd FileType tex let g:AutoPairs['\[']='\]' " 这个不好用，只有一个<left>
vnoremap<buffer> <leader>$ :<c-u>call SurroundSelected('$','$')<cr>
function! SurroundSelected(a,b)
	" if not in visual mode, insert a.b
	" execute "normal! `<i".a:a."\<esc>"."`>la".a:b."\<esc>"
	execute "normal! `>a".a:b."\<esc>"."`<i".a:a."\<esc>"
	return
endfun

" COMPILE:
if expand("%:e") == 'tex'	
	nnoremap<buffer> <Leader><F9> :call XeAndBibCompile()<CR>:!evince %:r.pdf &<CR>
	nnoremap<buffer> <F9> :call XelatexCompile()<CR>:!evince %:r.pdf &<CR>
	" command! Bib !bibtex %:r
	" command! Pdf w|cd %:h|!pdflatex %:t
	" nnoremap<buffer> <Leader><F9> :L<CR>:Bib<CR>:L<CR>:L<CR>:!evince %:r.pdf &<CR>
endif
function! XelatexCompile()
	write
	cd %:h
	!xelatex %:t
endfun
function! XeAndBibCompile()
	write
	cd %:h
	!xelatex %:t
	!bibtex %:r
	!xelatex %:t
	!xelatex %:t
	call MakeCiteList()
endfun
" setlocal textwidth = 82 "超过82个字符时自动换行

" Direct Complete:
let g:TabCompleteDIC={	"sub":"\\subsection{}\<left>" ,"sec":"\\section{}\<left>" ,"par":"\\paragraph{}\<left>" ,
						\ "text":"textsuperscript","textsuperscript":"textsubscript",
						\ "use":"\\usepackage{}\<left>" , 'ref':'autoref' , 'inc':'include', 'include':'\includegraphics[]{}'."\<left>\<left>\<left>" }
let g:TabMathCompleteDIC={ 'a':'\alpha' , 'b':'\beta' , 'c':'\chi' , 'd':'\delta' , 'e':'\epsilon' , 'f':'\phi' , 'g':'\gamma' , 'h':'\eta' , 'i':'\iota' , 'k':'\kappa' , 'l':'\lambda' , 'm':'\mu' , 'n':'\nu' , 'o':'\omega' , 'p':'\pi' , 'q':'\theta' , 'r':'\rho' , 's':'\sigma' , 't':'\tau' , 'u':'\upsilon' , 'x':'\xi' , 'z':'\zata',
							\ 'D':'\Delta','O':'\Omega', 'epsilon':'varepsilon',
							\ 'phi':'frac{}{}'.repeat("\<left>",3),'pi':'varphi', 'tau':'times','delta':'partial',
							\ 'Long':'\Longrightarrow', 'Longrightarrow':'Longleftarrow', 'Longleftarrow':'Longrightarrow'		}
let s:SnippetPath='/home/ck/.vim/Mytexcomplet/'

" inoremap <expr> 也可以调用
function! WordBeforeCursor()
	" \a: Alphabetic character; \A non-Alphabetic character
	let Start = col('.')-1
	let CurrentPos=Start
	let Line = getline('.')
	" 光标位于一个单词上时直接返回0
	if Line[Start] =~ '\a' || Line[Start-1] =~ '\A'	
		return
	endif		
	" locate the start of the word
	while Start > 0 && Line[Start-1] =~ '\a'
		let Start -= 1
	endwhile
	return Line[Start:CurrentPos-1]
endfun 

" TabComplete 除了实现此功能外，尝试类似sublime的Tab移动光标到相应位置 
" inoremap <tab> <c-r>=TabCompleteAndMove()  是不是能完全代替 inoremap <expr><tab>=
inoremap <tab> <c-r>=TabCompleteAndMove()<cr>
function! TabCompleteAndMove()			
	echom "Call TabComplete"
	let bword=WordBeforeCursor()
	let Len=len(bword)
	let z_register = @z				" protect the register
	let SynRegionOfCursor =  synIDattr(synID(line("."), col("."), 1), "name")
	" if the Delimiter or the line seperator(the cursor is at the end of line) is under the cursor:
	if SynRegionOfCursor == 'Delimiter' || SynRegionOfCursor == ''
		" let SynRegionOfBword =  synIDattr(synID(line("."), col(".")-1, 1), "name")
		let StackListOfSynID = synstack(line('.'),col('.')-1)
	else
		" let SynRegionOfBword = SynRegionOfCursor
		let StackListOfSynID = synstack(line('.'),col('.'))
	endif
	" decide the CompletMethod
	let CompletMethod = 'plain'
	for ID in StackListOfSynID
		if synIDattr(ID,"name") =~ "texComment"
			let CompletMethod = '0'
			break
			"elseif synIDattr(ID,"name")=="texInputFile"
		elseif synIDattr(ID,"name") =~ "texMath"
			let CompletMethod = 'math'
			break
		endif
	endfor
	if bword == 'cases'
		let CompletMethod = 'plain'
	endif

	if CompletMethod == '0'
		if pumvisible()
			return "\<c-n>"
		else 
			return "\<tab>"
		endif
	elseif CompletMethod == 'math'
		if has_key(g:TabMathCompleteDIC,bword)
			" when the cursor is at the end of line, <c-r>=Tem(n) will be dysfunctional
			return repeat("\<BS>",Len).g:TabMathCompleteDIC[bword]
		else
			return pumvisible() ? "\<c-n>" : "\<tab>"
		endif
	else	" CompletMethod == 'plain'
		if has_key(g:TabCompleteDIC,bword)
			" when the cursor is at the end of line, <c-r>=Tem(n) will be dysfunctional
			return repeat("\<BS>",Len).g:TabCompleteDIC[bword]
		elseif filereadable(s:SnippetPath.bword.'.tex')
			execute "r ".s:SnippetPath.bword.'.tex'
			normal "zdb
			let @z = z_register		" protect the register
			return "\<esc>".'/\~'
		else 
			return pumvisible() ? "\<c-n>" : "\<tab>"
		endif
	"elseif SynRegionOfCursor == 'Delimiter' —— CompletMethod = 'move'
	endif
	return 0
endfun

" Auto Complet: see help readfile() ,help system() e.g; join(readfiile("~/.vimrc"),"\n")
function! StringInsideTheNextBrace(open,close,var,start)
	let i=a:start
	let Start = -1
	let End = -1
	while i < len(a:var)
		if a:var[i] == a:open
			let Start = i
		elseif a:var[i] == a:close
			let End = i
			break
		endif
		let i = i+1
	endwhile
	if Start == -1 || End == -1
		return ''
	else
		return a:var[Start+1:End-1]
	endif
endfun

nnoremap<buffer> \ :call MakeRefList()<cr>:call ChinesesCount()<cr>
function! MakeRefList()
	silent write
	let refitem = system('grep \label{ '.expand('%'))
	let g:LatexRefList = []
	let i=0
	while i < len(refitem)
		if refitem[i] == '{' && refitem[i-5:i-1] == 'label'
			let aitem = StringInsideTheNextBrace('{','}',refitem,i)
			call add(g:LatexRefList,aitem)
			let i = i+len(aitem)
		endif
		let i=i+1
	endwhile
endfun
" \bibliography{123,456}
function! MakeCiteList()
	cd %:h
	let g:LatexCiteList=[]
	let bibfiles = system('grep \bibliography{ '.expand('%'))
	if bibfiles ==''
		return 
	endif
	let bibfiles = split(StringInsideTheNextBrace('{','}',bibfiles,0),',')
	for File in bibfiles
		if File[len(File)-4:len(File)-1] != '.bib'
			let File = File.'.bib'
		endif
		let bibitem = system('grep @ '.File)
		for item in split(bibitem,"\n")
			call add(g:LatexCiteList, StringInsideTheNextBrace('{',',',item,0))
		endfor
	endfor
	return bibfiles
endfun
" inoremap { <c-r>=CompleteRefList()<cr>
" 不能用map {?
inoremap <leader><leader> <c-r>=CompleteRefCiteList()<cr>
function! CompleteRefCiteList()
	let Line = getline('.')
	let EndPos = getcurpos()
	normal F{
	let StartCol = col('.')
	let l:Leader = Line[StartCol:EndPos[2]-2]	" the pre-typed text 
	let Bword = WordBeforeCursor()
	if Bword =~ 'ref'
		let CompletList = g:LatexRefList
	elseif Bword =~ 'cite'
		let CompletList = g:LatexCiteList
	else 
		call setpos('.',EndPos)
		return '  '
	endif

	call setpos('.',EndPos)
	" call complete(col('.'),g:LatexRefList)	
	let res = []
	for m in CompletList
		if m =~ l:Leader
			call add(res,m)
		endif
	endfor
	call complete(col('.')-len(l:Leader),res)
	return ''
endfun
" TEST:\subsection{0}
" $\subsection{}\subsection{} {}

" 1.1 光标在math模式的括号内时，有同一个快捷键使得：() -->  \left ( \right ), [] --> \left [ \right ]
" 2. \begin{}\end{}内的东西同步变化，
" 3. " 根据.aux文件的内容写一个类似Tagbar的东西，要将图片的label和pdf中图片的编号写在一起
