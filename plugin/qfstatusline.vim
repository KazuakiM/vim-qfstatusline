if &cp || (exists('g:loaded_qfstatusline') && g:loaded_qfstatusline)
    finish
endif
let g:loaded_qfstatusline  = 1

command! QfstatuslineUpdate :call qfstatusline#Qfstatusline()

