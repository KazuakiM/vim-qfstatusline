let s:save_cpo = &cpo
set cpo&vim

"variable {{{
if !exists('g:Qfstatusline#UpdateCmd')
    echohl ErrorMsg | echomsg "vim-qfstatusline: require 'g:Qfstatusline#UpdateCmd = function()'" | echohl None
    finish
endif
let g:Qfstatusline#Text = ! exists('g:Qfstatusline#Text') ? 1 :                        g:Qfstatusline#Text
let s:checkDict         = ! exists('s:checkDict')         ? {'check': 0, 'text': ''} : s:checkDict
"}}}
function! qfstatusline#Qfstatusline() abort "{{{
    let s:checkDict = {'check': 1, 'text': ''}
    call g:Qfstatusline#UpdateCmd()
endfunction "}}}
function! qfstatusline#Update() abort "{{{
    if s:checkDict.check ==# 0
        return s:checkDict.text
    endif

    "Setting statusline
    let a:bufnr = bufnr('%')
    "Depend on check logic. So maybe all OK.
    let a:errorNum  = 9999
    let a:errorFnr  = []
    for a:qfrow in getqflist()
        if a:qfrow.bufnr ==# a:bufnr && 0 < a:qfrow.lnum && count(a:errorFnr, a:qfrow.lnum) ==# 0
            if a:qfrow.lnum <= a:errorNum
                let a:errorNum  = a:qfrow.lnum
                let s:checkDict = {'check': 0, 'text': a:qfrow.text}
            endif
            call add(a:errorFnr, a:qfrow.lnum)
        endif
    endfor
    let a:errorFnrLen = len(a:errorFnr)
    if 0 < a:errorFnrLen
        if g:Qfstatusline#Text
            return 'L'.a:errorNum.'('.a:errorFnrLen.') M:'.s:checkDict.text
        else
            return 'Error: L'.a:errorNum.'('.a:errorFnrLen.')'
        endif
    endif

    let s:checkDict = {'check': 0, 'text': ''}
    return s:checkDict.text
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

