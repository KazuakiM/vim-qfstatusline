let s:save_cpo = &cpo
set cpo&vim

"variable {{{
if !exists('g:Qfstatusline#UpdateCmd')
    echohl ErrorMsg | echomsg "vim-qfstatusline: require 'g:Qfstatusline#UpdateCmd = function()'" | echohl None
    finish
endif
"}}}

function! qfstatusline#Qfstatusline() "{{{
    call g:Qfstatusline#UpdateCmd()
endfunction "}}}

function! qfstatusline#Update() "{{{
    "Setting statusline
    let a:bufnr    = bufnr('%')
    let a:errorNum = line('$')
    let a:errorFnr = []
    for a:qfrow in getqflist()
        if a:qfrow.bufnr == a:bufnr
            if a:qfrow.lnum > 0
                if count(a:errorFnr, a:qfrow.lnum) == 0
                    let a:errorNum  = (a:qfrow.lnum < a:errorNum) ? a:qfrow.lnum : a:errorNum
                    call add(a:errorFnr, a:qfrow.lnum)
                endif
            endif
        endif
    endfor
    let a:errorFnrLen = len(a:errorFnr)
    return (a:errorFnrLen > 0) ? 'Error: L'.a:errorNum.'('.a:errorFnrLen.')' : ''
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

