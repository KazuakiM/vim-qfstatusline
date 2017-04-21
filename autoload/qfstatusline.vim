let s:save_cpo = &cpo
set cpo&vim

"variable {{{
if !exists('g:Qfstatusline#UpdateCmd')
    echohl ErrorMsg | echomsg "vim-qfstatusline: require 'g:Qfstatusline#UpdateCmd = function()'" | echohl None
    finish
endif
let g:Qfstatusline#Text = ! exists('g:Qfstatusline#Text') ? 1 :                        g:Qfstatusline#Text
"}}}

function! qfstatusline#Qfstatusline() abort "{{{
    return g:Qfstatusline#UpdateCmd()
endfunction "}}}

function! qfstatusline#Update() abort "{{{
    let l:qflist = getqflist()
    let l:errorCount = len(l:qflist)
    let l:errorLine = 0
    let l:returnText = ''

    " No Error
    if l:errorCount == 0
      return l:returnText
    endif

    " Exist Errors
    let l:currentBufferName = bufnr('%')
    let l:firstErrorRow = l:qflist[0]
    if l:firstErrorRow.bufnr ==# l:currentBufferName && 0 < l:firstErrorRow.lnum
        let l:errorLine = l:firstErrorRow.lnum
    endif

    let l:returnText = l:errorCount . ' error'
    if 1 < l:errorCount
      let l:returnText .= 's'
    endif
    let l:returnText .= '. Line: ' . l:errorLine

    return l:returnText

endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

