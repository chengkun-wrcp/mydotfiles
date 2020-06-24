"see: /usr/share/vim/vim80/syntax/help.vim
" syntax keyword noteMathSymbol cheng		conceal cchar=程
"GreekSymbol {{{
syntax keyword noteMathSymbol beta    	conceal cchar=β
syntax keyword noteMathSymbol gamma   	conceal cchar=γ
syntax keyword noteMathSymbol delta   	conceal cchar=δ
syntax keyword noteMathSymbol epsilon 	conceal cchar=ε
syntax keyword noteMathSymbol alpha		conceal cchar=α
syntax keyword noteMathSymbol beta		conceal cchar=β
syntax keyword noteMathSymbol gamma		conceal cchar=γ
syntax keyword noteMathSymbol delta		conceal cchar=δ
syntax keyword noteMathSymbol epsilon	conceal cchar=ϵ
syntax keyword noteMathSymbol varepsilon	conceal cchar=ε
syntax keyword noteMathSymbol zeta		conceal cchar=ζ
syntax keyword noteMathSymbol eta		conceal cchar=η
syntax keyword noteMathSymbol theta		conceal cchar=θ
syntax keyword noteMathSymbol vartheta	conceal cchar=ϑ
syntax keyword noteMathSymbol kappa		conceal cchar=κ
syntax keyword noteMathSymbol lambda	conceal cchar=λ
syntax keyword noteMathSymbol mu		conceal cchar=μ
syntax keyword noteMathSymbol nu		conceal cchar=ν
syntax keyword noteMathSymbol xi		conceal cchar=ξ
syntax keyword noteMathSymbol pi		conceal cchar=π
syntax keyword noteMathSymbol varpi		conceal cchar=ϖ
syntax keyword noteMathSymbol rho		conceal cchar=ρ
syntax keyword noteMathSymbol varrho	conceal cchar=ϱ
syntax keyword noteMathSymbol sigma		conceal cchar=σ
syntax keyword noteMathSymbol varsigma	conceal cchar=ς
syntax keyword noteMathSymbol tau		conceal cchar=τ
syntax keyword noteMathSymbol upsilon	conceal cchar=υ
syntax keyword noteMathSymbol phi		conceal cchar=ϕ
syntax keyword noteMathSymbol varphi	conceal cchar=φ
syntax keyword noteMathSymbol chi		conceal cchar=χ
syntax keyword noteMathSymbol psi		conceal cchar=ψ
syntax keyword noteMathSymbol omega		conceal cchar=ω
syntax keyword noteMathSymbol Gamma		conceal cchar=Γ
syntax keyword noteMathSymbol Delta		conceal cchar=Δ
syntax keyword noteMathSymbol Theta		conceal cchar=Θ
syntax keyword noteMathSymbol Lambda	conceal cchar=Λ
syntax keyword noteMathSymbol Xi		conceal cchar=Χ
syntax keyword noteMathSymbol Pi		conceal cchar=Π
syntax keyword noteMathSymbol Sigma		conceal cchar=Σ
syntax keyword noteMathSymbol Upsilon	conceal cchar=Υ
syntax keyword noteMathSymbol Phi		conceal cchar=Φ
syntax keyword noteMathSymbol Psi		conceal cchar=Ψ
syntax keyword noteMathSymbol Omega		conceal cchar=Ω
"}}}
" " Superscripts/Subscripts {{{2
" syn region texSuperscript	matchgroup=Delimiter start='\^{'	skip="\\\\\|\\[{}]" end='}'	contained concealends contains=texSpecialChar,texSuperscripts,texStatement,texSubscript,texSuperscript,texMathMatcher
" syn region texSubscript	matchgroup=Delimiter start='_{'		skip="\\\\\|\\[{}]" end='}'	contained concealends contains=texSpecialChar,texSubscripts,texStatement,texSubscript,texSuperscript,texMathMatcher
" " s:SuperSub:
" fun! s:SuperSub(group,leader,pat,cchar)
" 	if a:pat =~# '^\\' || (a:leader == '\^' && a:pat =~# s:tex_superscripts) || (a:leader == '_' && a:pat =~# s:tex_subscripts)
" 		"     call Decho("SuperSub: group<".a:group."> leader<".a:leader."> pat<".a:pat."> cchar<".a:cchar.">")
" 		exe 'syn match '.a:group." '".a:leader.a:pat."' contained conceal cchar=".a:cchar
" 		exe 'syn match '.a:group."s '".a:pat        ."' contained conceal cchar=".a:cchar.' nextgroup='.a:group.'s'
" 	endif
" endfun
" call s:SuperSub('texSuperscript','\^','0','⁰')
" call s:SuperSub('texSuperscript','\^','1','¹')
" call s:SuperSub('texSuperscript','\^','2','²')
" call s:SuperSub('texSuperscript','\^','3','³')
" call s:SuperSub('texSuperscript','\^','4','⁴')
" call s:SuperSub('texSuperscript','\^','5','⁵')
" call s:SuperSub('texSuperscript','\^','6','⁶')
" call s:SuperSub('texSuperscript','\^','7','⁷')
" call s:SuperSub('texSuperscript','\^','8','⁸')
" call s:SuperSub('texSuperscript','\^','9','⁹')
" call s:SuperSub('texSuperscript','\^','a','ᵃ')
" call s:SuperSub('texSuperscript','\^','b','ᵇ')
" call s:SuperSub('texSuperscript','\^','c','ᶜ')
" call s:SuperSub('texSuperscript','\^','d','ᵈ')
" call s:SuperSub('texSuperscript','\^','e','ᵉ')
" call s:SuperSub('texSuperscript','\^','f','ᶠ')
" call s:SuperSub('texSuperscript','\^','g','ᵍ')
" call s:SuperSub('texSuperscript','\^','h','ʰ')
" call s:SuperSub('texSuperscript','\^','i','ⁱ')
" call s:SuperSub('texSuperscript','\^','j','ʲ')
" call s:SuperSub('texSuperscript','\^','k','ᵏ')
" call s:SuperSub('texSuperscript','\^','l','ˡ')
" call s:SuperSub('texSuperscript','\^','m','ᵐ')
" call s:SuperSub('texSuperscript','\^','n','ⁿ')
" call s:SuperSub('texSuperscript','\^','o','ᵒ')
" call s:SuperSub('texSuperscript','\^','p','ᵖ')
" call s:SuperSub('texSuperscript','\^','r','ʳ')
" call s:SuperSub('texSuperscript','\^','s','ˢ')
" call s:SuperSub('texSuperscript','\^','t','ᵗ')
" call s:SuperSub('texSuperscript','\^','u','ᵘ')
" call s:SuperSub('texSuperscript','\^','v','ᵛ')
" call s:SuperSub('texSuperscript','\^','w','ʷ')
" call s:SuperSub('texSuperscript','\^','x','ˣ')
" call s:SuperSub('texSuperscript','\^','y','ʸ')
" call s:SuperSub('texSuperscript','\^','z','ᶻ')
" call s:SuperSub('texSuperscript','\^','A','ᴬ')
" call s:SuperSub('texSuperscript','\^','B','ᴮ')
" call s:SuperSub('texSuperscript','\^','D','ᴰ')
" call s:SuperSub('texSuperscript','\^','E','ᴱ')
" call s:SuperSub('texSuperscript','\^','G','ᴳ')
" call s:SuperSub('texSuperscript','\^','H','ᴴ')
" call s:SuperSub('texSuperscript','\^','I','ᴵ')
" call s:SuperSub('texSuperscript','\^','J','ᴶ')
" call s:SuperSub('texSuperscript','\^','K','ᴷ')
" call s:SuperSub('texSuperscript','\^','L','ᴸ')
" call s:SuperSub('texSuperscript','\^','M','ᴹ')
" call s:SuperSub('texSuperscript','\^','N','ᴺ')
" call s:SuperSub('texSuperscript','\^','O','ᴼ')
" call s:SuperSub('texSuperscript','\^','P','ᴾ')
" call s:SuperSub('texSuperscript','\^','R','ᴿ')
" call s:SuperSub('texSuperscript','\^','T','ᵀ')
" call s:SuperSub('texSuperscript','\^','U','ᵁ')
" call s:SuperSub('texSuperscript','\^','W','ᵂ')
" call s:SuperSub('texSuperscript','\^',',','︐')
" call s:SuperSub('texSuperscript','\^',':','︓')
" call s:SuperSub('texSuperscript','\^',';','︔')
" call s:SuperSub('texSuperscript','\^','+','⁺')
" call s:SuperSub('texSuperscript','\^','-','⁻')
" call s:SuperSub('texSuperscript','\^','<','˂')
" call s:SuperSub('texSuperscript','\^','>','˃')
" call s:SuperSub('texSuperscript','\^','/','ˊ')
" call s:SuperSub('texSuperscript','\^','(','⁽')
" call s:SuperSub('texSuperscript','\^',')','⁾')
" call s:SuperSub('texSuperscript','\^','\.','˙')
" call s:SuperSub('texSuperscript','\^','=','˭')
" call s:SuperSub('texSubscript','_','0','₀')
" call s:SuperSub('texSubscript','_','1','₁')
" call s:SuperSub('texSubscript','_','2','₂')
" call s:SuperSub('texSubscript','_','3','₃')
" call s:SuperSub('texSubscript','_','4','₄')
" call s:SuperSub('texSubscript','_','5','₅')
" call s:SuperSub('texSubscript','_','6','₆')
" call s:SuperSub('texSubscript','_','7','₇')
" call s:SuperSub('texSubscript','_','8','₈')
" call s:SuperSub('texSubscript','_','9','₉')
" call s:SuperSub('texSubscript','_','a','ₐ')
" call s:SuperSub('texSubscript','_','e','ₑ')
" call s:SuperSub('texSubscript','_','h','ₕ')
" call s:SuperSub('texSubscript','_','i','ᵢ')
" call s:SuperSub('texSubscript','_','j','ⱼ')
" call s:SuperSub('texSubscript','_','k','ₖ')
" call s:SuperSub('texSubscript','_','l','ₗ')
" call s:SuperSub('texSubscript','_','m','ₘ')
" call s:SuperSub('texSubscript','_','n','ₙ')
" call s:SuperSub('texSubscript','_','o','ₒ')
" call s:SuperSub('texSubscript','_','p','ₚ')
" call s:SuperSub('texSubscript','_','r','ᵣ')
" call s:SuperSub('texSubscript','_','s','ₛ')
" call s:SuperSub('texSubscript','_','t','ₜ')
" call s:SuperSub('texSubscript','_','u','ᵤ')
" call s:SuperSub('texSubscript','_','v','ᵥ')
" call s:SuperSub('texSubscript','_','x','ₓ')
" call s:SuperSub('texSubscript','_',',','︐')
" call s:SuperSub('texSubscript','_','+','₊')
" call s:SuperSub('texSubscript','_','-','₋')
" call s:SuperSub('texSubscript','_','/','ˏ')
" call s:SuperSub('texSubscript','_','(','₍')
" call s:SuperSub('texSubscript','_',')','₎')
" call s:SuperSub('texSubscript','_','\.','‸')
" call s:SuperSub('texSubscript','_','r','ᵣ')
" call s:SuperSub('texSubscript','_','v','ᵥ')
" call s:SuperSub('texSubscript','_','x','ₓ')
" call s:SuperSub('texSubscript','_','\\beta\>' ,'ᵦ')
" call s:SuperSub('texSubscript','_','\\delta\>','ᵨ')
" call s:SuperSub('texSubscript','_','\\phi\>'  ,'ᵩ')
" call s:SuperSub('texSubscript','_','\\gamma\>','ᵧ')
" call s:SuperSub('texSubscript','_','\\chi\>'  ,'ᵪ')

" delfun s:SuperSub

