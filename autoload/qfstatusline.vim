let s:save_cpo = &cpo
set cpo&vim

"variable {{{
if !exists('g:Qfstatusline#UpdateCmd')
    echohl ErrorMsg | echomsg "vim-qfstatusline: require 'g:Qfstatusline#UpdateCmd = function()'" | echohl None
    finish
endif
let g:Qfstatusline#Text = ! exists('g:Qfstatusline#Text') ? 1 : g:Qfstatusline#Text
"}}}
function! qfstatusline#Qfstatusline() "{{{
    call g:Qfstatusline#UpdateCmd()
endfunction "}}}
function! qfstatusline#Update() "{{{
    "Setting statusline
    let a:bufnr = bufnr('%')
    "Depend on check logic. So maybe all OK.
    let a:errorNum  = 9999
    let a:errorText = ''
    let a:errorFnr  = []
    for a:qfrow in getqflist()
        if a:qfrow.bufnr ==# a:bufnr && 0 < a:qfrow.lnum && count(a:errorFnr, a:qfrow.lnum) ==# 0
            if a:qfrow.lnum <= a:errorNum
                let a:errorNum  = a:qfrow.lnum
                let a:errorText = a:qfrow.text
            endif
            call add(a:errorFnr, a:qfrow.lnum)
        endif
    endfor
    let a:errorFnrLen = len(a:errorFnr)
    if 0 < a:errorFnrLen
        if g:Qfstatusline#Text
            return 'L'.a:errorNum.'('.a:errorFnrLen.') M:'.a:errorText
        else
            return 'Error: L'.a:errorNum.'('.a:errorFnrLen.')'
        endif
    endif
    return ''
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

