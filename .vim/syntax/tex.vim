" set conceallevel=2
if !exists("g:tex_conceal")
 let s:tex_conceal= 'abdmgsS'
else
 let s:tex_conceal= g:tex_conceal
endif
hi clear Conceal
" let g:tex_superscripts=
" let g:tex_subscripts=
" let g:tex_conceal='abdmgsS'
" syn region texSuperscript	matchgroup=Delimiter start='\^{'	skip="\\\\\|\\[{}]" end='}'	contained contains=texSpecialChar,texSuperscripts,texStatement,texSubscript,texSuperscript,texMathMatcher
" syn region texSubscript	matchgroup=Delimiter start='_{'		skip="\\\\\|\\[{}]" end='}'	contained contains=texSpecialChar,texSubscripts,texStatement,texSubscript,texSuperscript,texMathMatcher
"
syntax region texRefZone start="\\autoref{" end="}"
syntax region texCiteZone start="\\supercite{" end="}"
if has("conceal") && &enc == 'utf-8'
	if s:tex_conceal =~# 'm'
		syn match texMathSymbol '\\bar{a}' contained conceal cchar=a̅
		syn match texMathSymbol '\\tilde{A}' contained conceal cchar=Ã
		syn match texMathSymbol '\\tilde{a}' contained conceal cchar=ã
		syn match texMathSymbol '\\tilde{e}' contained conceal cchar=ẽ
		syn match texMathSymbol '\\tilde{E}' contained conceal cchar=Ẽ
		syn match texMathSymbol '\\tilde{i}' contained conceal cchar=ĩ
		syn match texMathSymbol '\\tilde{I}' contained conceal cchar=Ĩ
		syn match texMathSymbol '\\tilde{n}' contained conceal cchar=ñ
		syn match texMathSymbol '\\tilde{N}' contained conceal cchar=Ñ
		syn match texMathSymbol '\\tilde{o}' contained conceal cchar=õ
		syn match texMathSymbol '\\tilde{O}' contained conceal cchar=Õ
		syn match texMathSymbol '\\tilde{u}' contained conceal cchar=ũ
		syn match texMathSymbol '\\tilde{U}' contained conceal cchar=Ũ
		syn match texMathSymbol '\\tilde{y}' contained conceal cchar=ỹ
		syn match texMathSymbol '\\tilde{Y}' contained conceal cchar=Ỹ
		" bar
		syn match texMathSymbol '\\bar{a}' contained conceal cchar=ā
		syn match texMathSymbol '\\bar{A}' contained conceal cchar=Ā
		syn match texMathSymbol '\\bar{e}' contained conceal cchar=ē
		syn match texMathSymbol '\\bar{E}' contained conceal cchar=Ē
		syn match texMathSymbol '\\bar{i}' contained conceal cchar=ī
		syn match texMathSymbol '\\bar{I}' contained conceal cchar=Ī
		syn match texMathSymbol '\\bar{o}' contained conceal cchar=ō
		syn match texMathSymbol '\\bar{O}' contained conceal cchar=Ō
 	endif
endif
