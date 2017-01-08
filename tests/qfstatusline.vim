let s:suite                  = themis#suite('qfstatusline')
let s:assert                 = themis#helper('assert')
let g:Qfstatusline#UpdateCmd = function('qfstatusline#UpdateTests')

function! qfstatusline#UpdateTests() abort "{{{
    return qfstatusline#Update()
endfunction "}}}

function! s:suite.before_each() abort "{{{
    call setqflist([])
    call qfstatusline#Update()
endfunction "}}}

function! s:suite.QfstatuslineText() abort "{{{
    let g:Qfstatusline#Text = 1

    call s:assert.equals(qfstatusline#Qfstatusline(), '')
    call s:assert.equals(qfstatusline#Update(),       '')

    call setqflist([
        \ {'lnum': 8, 'bufnr': 1, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': ' syntax error, unexpected tIDENTIFIER, expecting keyword_end'},
        \ {'lnum': 0, 'bufnr': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': '  depends_on ''ctags'''}, ])
    call s:assert.equals(qfstatusline#Update(),       '')
    call s:assert.equals(qfstatusline#Qfstatusline(), 'L8(1) M: syntax error, unexpected tIDENTIFIER, expecting keyword_end')
    call s:assert.equals(qfstatusline#Update(),       'L8(1) M: syntax error, unexpected tIDENTIFIER, expecting keyword_end')

    call setqflist([
        \ {'lnum': 10, 'bufnr': 1, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': ' syntax error, unexpected tIDENTIFIER, expecting keyword_end'},
        \ {'lnum': 9,  'bufnr': 1, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': 'Parse error: syntax error, unexpected ''$requested'' (T_VARIABLE)'},
        \ {'lnum': 0,  'bufnr': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': 'Errors parsing /srv/kazuakim/server.php'}, ])
    call s:assert.equals(qfstatusline#Update(),       'L8(1) M: syntax error, unexpected tIDENTIFIER, expecting keyword_end')
    call s:assert.equals(qfstatusline#Qfstatusline(), 'L9(2) M:Parse error: syntax error, unexpected ''$requested'' (T_VARIABLE)')
    call s:assert.equals(qfstatusline#Update(),       'L9(2) M:Parse error: syntax error, unexpected ''$requested'' (T_VARIABLE)')

    call setqflist([])
    call s:assert.equals(qfstatusline#Update(),       'L9(2) M:Parse error: syntax error, unexpected ''$requested'' (T_VARIABLE)')
    call s:assert.equals(qfstatusline#Qfstatusline(), '')
    call s:assert.equals(qfstatusline#Update(),       '')
endfunction "}}}

function! s:suite.QfstatuslineNoneText() abort "{{{
    let g:Qfstatusline#Text = 0

    call s:assert.equals(qfstatusline#Qfstatusline(), '')
    call s:assert.equals(qfstatusline#Update(),       '')

    call setqflist([
        \ {'lnum': 8, 'bufnr': 1, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': ' syntax error, unexpected tIDENTIFIER, expecting keyword_end'},
        \ {'lnum': 0, 'bufnr': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': '  depends_on ''ctags'''}, ])
    call s:assert.equals(qfstatusline#Update(),       '')
    call s:assert.equals(qfstatusline#Qfstatusline(), 'Error: L8(1)')
    call s:assert.equals(qfstatusline#Update(),       'Error: L8(1)')

    call setqflist([
        \ {'lnum': 10, 'bufnr': 1, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': ' syntax error, unexpected tIDENTIFIER, expecting keyword_end'},
        \ {'lnum': 9,  'bufnr': 1, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': 'Parse error: syntax error, unexpected ''$requested'' (T_VARIABLE)'},
        \ {'lnum': 0,  'bufnr': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'text': 'Errors parsing /srv/kazuakim/server.php'}, ])
    call s:assert.equals(qfstatusline#Update(),       'Error: L8(1)')
    call s:assert.equals(qfstatusline#Qfstatusline(), 'Error: L9(2)')
    call s:assert.equals(qfstatusline#Update(),       'Error: L9(2)')

    call setqflist([])
    call s:assert.equals(qfstatusline#Update(),       'Error: L9(2)')
    call s:assert.equals(qfstatusline#Qfstatusline(), '')
    call s:assert.equals(qfstatusline#Update(),       '')
endfunction "}}}
