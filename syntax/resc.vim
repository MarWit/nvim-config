if exists("b:current_syntax")
  finish
endif

" this file uses line continuation
let s:cpo_save = &cpo
set cpo&vim

syn include @rescPython syntax/python.vim
unlet b:current_syntax

syn match keywords /^[a-zA-Z][a-zA-Z0-9_]*/
syn match keywords /python/

syn region pythonCode matchgroup=parens start=/python[[:blank:]\r\n]"""/ end=/"""/ contains=@rescPython
syn region pythonCode matchgroup=parens start=/python[[:blank:]]"/ end=/"/ contains=@rescPython
syn region string start=/"[^"]\+/hs=s+1 end=/"/he=e-1
syn region string start=/@/hs=s+1 end=/$/ keepend
syn region string start=/"""/hs=s+3 end=/"""/he=e-3
syn match comment /[#:].*/
syn match variable /\$[a-zA-Z0-9_]\+/

hi link keywords @keyword
hi link comment @comment
hi link variable @constant
hi link string @string

let b:current_syntax = "resc"

let &cpo = s:cpo_save
unlet! s:cpo_save
