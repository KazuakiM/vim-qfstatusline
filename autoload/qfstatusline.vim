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

    return g:Qfstatusline#UpdateCmd()
endfunction "}}}
function! qfstatusline#Update() abort "{{{
    if s:checkDict.check ==# 0
        return s:checkDict.text
    endif

    "Setting statusline
    let l:bufnr = bufnr('%')
    "Depend on check logic. So maybe all OK.
    let l:errorDict = {'num': 9999, 'text': ''}
    let l:errorFnr  = []
    for l:qfrow in getqflist()
        if l:qfrow.bufnr ==# l:bufnr && 0 < l:qfrow.lnum && count(l:errorFnr, l:qfrow.lnum) ==# 0
            if l:qfrow.lnum <= l:errorDict.num
                let l:errorDict = {'num': l:qfrow.lnum, 'text': l:qfrow.text}
            endif
            call add(l:errorFnr, l:qfrow.lnum)
        endif
    endfor
    let l:errorFnrLen = len(l:errorFnr)
    if 0 < l:errorFnrLen
        if g:Qfstatusline#Text
            let s:checkDict = {'check': 0, 'text': 'L'.l:errorDict.num.'('.l:errorFnrLen.') M:'.l:errorDict.text}
        else
            let s:checkDict = {'check': 0, 'text': 'Error: L'.l:errorDict.num.'('.l:errorFnrLen.')'}
        endif
        return s:checkDict.text
    endif

    let s:checkDict = {'check': 0, 'text': ''}
    return s:checkDict.text
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

