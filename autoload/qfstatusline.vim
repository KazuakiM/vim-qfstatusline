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
    let a:bufnr = bufnr('%')
    for a:qfrow in getqflist()
        if a:qfrow.bufnr == a:bufnr
            if a:qfrow.lnum > 0
                return 'Syntax:L'.a:qfrow.lnum
            endif
        endif
    endfor
    return ''
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

