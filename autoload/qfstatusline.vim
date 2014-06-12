let s:save_cpo = &cpo
set cpo&vim

let g:qfstatusline_enabled = ! exists('g:qfstatusline_enabled') ? 1 : g:qfstatusline_enabled

if !exists('g:Qfstatusline#UpdateCmd')
    echohl ErrorMsg | echomsg "vim-qfstatusline: require 'g:Qfstatusline#UpdateCmd = function()'" | echohl None
    finish
endif

function! qfstatusline#Qfstatusline() "{{{
    call g:Qfstatusline#UpdateCmd()
endfunction "}}}

function! qfstatusline#Update() "{{{
    "Make statusline message
    let a:qfstatusline_message = ''
    "Setting statusline
    let a:bufnr = bufnr('%')
    for a:qfrow in getqflist()
        if a:qfrow.bufnr == a:bufnr
            if a:qfrow.lnum > 0
                let a:qfstatusline_message = 'Syntax:L'.a:qfrow.lnum
                break
            endif
        endif
    endfor
    return a:qfstatusline_message
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

