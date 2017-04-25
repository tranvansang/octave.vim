" Vim indent file
" Language:    Octave
" Maintainer:  Tran Van Sang <tranvansang@gmail.com>
" Original Author:  Tran Van Sang <tranvansang@gmail.com>
" Created:     2016 Apr 25
" Last Change: 2016 Apr 25


if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

setlocal indentexpr=GetOctaveIndent(v:lnum)
setlocal indentkeys&
setlocal indentkeys+==end,==endfor,==endparfor,==endfunction,==endif,==endswitch
setlocal indentkeys+==end_try_catch,==end_unwind_protect,==endwhile,==until
setlocal indentkeys+==endclassdef,==endenumeration,==endevents,==endmethods
setlocal indentkeys+==endproperties
setlocal indentkeys+=;,),]

if exists("*GetOctaveIndent")
	finish
endif


function! s:GetPrevNonCommentLineNum( line_num, is_in_block_comment )
  if a:line_num <= 0
    return 0
  endif
  let l:nline = prevnonblank(a:line_num - 1)
  let l:last_line = getline(l:nline)
  if l:last_line =~ '^\s*%}\s*$'
    return s:GetPrevNonCommentLineNum(l:nline, 1)
  elseif l:last_line =~ '^\s*#}\s*$'
    return s:GetPrevNonCommentLineNum(l:nline, 2)
  elseif l:last_line =~ '^\s*#'
    return s:GetPrevNonCommentLineNum(l:nline, a:is_in_block_comment)
  elseif a:is_in_block_comment == 1
    if l:last_line =~ '^\s*%{\s*$'
      return s:GetPrevNonCommentLineNum(l:nline, 0)
    else
      return s:GetPrevNonCommentLineNum(l:nline, a:is_in_block_comment)
    endif
  elseif a:is_in_block_comment == 2
    if l:last_line =~ '^\s*#{\s*$'
      return s:GetPrevNonCommentLineNum(l:nline, 0)
    else
      return s:GetPrevNonCommentLineNum(l:nline, a:is_in_block_comment)
    endif
  else
    return l:nline
  endif
endfunction


function! GetOctaveIndent( line_num )
  let l:SHIFT_IN = '^\s*\<\(for\|parfor\|function\|if\|switch\|try\|unwind_protect\|while\|do\|classdef\|enumeration\|events\|methods\|properties\|case\|catch\|else\|elseif\|otherwise\|unwind_protect_cleanup\)\>'
  let l:SHIFT_OUT = '^\s*\<\(end\|endfor\|endparfor\|endfunction\|endif\|endswitch\|end_try_catch\|end_unwind_protect\|endwhile\|until\|endclassdef\|endenumeration\|endevents\|endmethods\|endproperties\)\>'

	" Line 0 always goes at column 0
	if a:line_num == 0
		return 0
	endif

	let l:this_codeline = getline( a:line_num )

	" If is a comment
	if l:this_codeline =~ '^\s*#'
		return indent( a:line_num )
	endif

	let l:prev_codeline_num = s:GetPrevNonCommentLineNum( a:line_num, 0 )
	let l:prev_codeline = getline( l:prev_codeline_num )
	let l:indnt = indent( l:prev_codeline_num )

	" If the previous line was indenting...
  if l:prev_codeline =~ l:SHIFT_IN
		" then indent.
		let l:indnt = l:indnt + &shiftwidth
	endif
  if l:this_codeline =~ l:SHIFT_OUT
		let l:indnt = l:indnt - &shiftwidth
	endif

  " open braces
	if l:prev_codeline =~ '[(\[]\s*$'
		return l:indnt + &shiftwidth
	endif
  " close braces
	if l:this_codeline =~ '^\s*[)\]]'
		let l:indnt = l:indnt - &shiftwidth
	endif

	return l:indnt
endfunction

