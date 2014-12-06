let s:save_cpo = &cpo
set cpo&vim

"variable {{{
if !exists('g:Qfstatusline#UpdateCmd')
    echohl ErrorMsg | echomsg "vim-qfstatusline: require 'g:Qfstatusline#UpdateCmd = function()'" | echohl None
    finish
endif
let g:Qfstatusline#Text = ! exists('g:Qfstatusline#Text') ? 0 : g:Qfstatusline#Text
"}}}
function! qfstatusline#Qfstatusline() "{{{
    call g:Qfstatusline#UpdateCmd()
endfunction "}}}
function! qfstatusline#Update() "{{{
    "Setting statusline
    let a:bufnr     = bufnr('%')
    let a:errorNum  = line('$')
    let a:errorText = ''
    let a:errorFnr  = []
    for a:qfrow in getqflist()
        if (a:qfrow.bufnr ==# a:bufnr)&&(a:qfrow.lnum > 0)&&(count(a:errorFnr, a:qfrow.lnum) ==# 0)
            if (a:qfrow.lnum < a:errorNum)
                let a:errorNum  = a:qfrow.lnum
                let a:errorText = a:qfrow.text
            endif
            call add(a:errorFnr, a:qfrow.lnum)
        endif
    endfor
    let a:errorFnrLen = len(a:errorFnr)
    if (a:errorFnrLen > 0)&&(g:Qfstatusline#Text)
        return 'L'.a:errorNum.'('.a:errorFnrLen.') M:'.a:errorText
    elseif (a:errorFnrLen > 0)
        return 'Error: L'.a:errorNum.'('.a:errorFnrLen.')'
    endif
    return ''
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

