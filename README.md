#vim-qfstatusline

[![](https://img.shields.io/travis/KazuakiM/vim-qfstatusline.svg)](https://travis-ci.org/KazuakiM/vim-qfstatusline)
[![Build status](https://ci.appveyor.com/api/projects/status/lte1vdem9lmsyjo3/branch/master?svg=true)](https://ci.appveyor.com/project/KazuakiM/vim-qfstatusline/branch/master)
[![](https://img.shields.io/github/issues/KazuakiM/vim-qfstatusline.svg)](https://github.com/KazuakiM/vim-qfstatusline/issues)
[![](https://img.shields.io/badge/doc-%3Ah%20qfstatusline.txt-blue.svg)](doc/qfstatusline.txt)
[![](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

This Vim plugin is plugin supporting [watchdogs](https://github.com/osyo-manga/vim-watchdogs).  
If [watchdogs](https://github.com/osyo-manga/vim-watchdogs) check syntax error,
this plugin execute statusline plugin function and statusline plugin call back to get error messages.

##Requirement

* [vimproc](https://github.com/Shougo/vimproc)
* [vim-quickrun](https://github.com/thinca/vim-quickrun)
* [shabadou.vim](https://github.com/osyo-manga/shabadou.vim)
* [watchdogs](https://github.com/osyo-manga/vim-watchdogs)

##Recommends

* [lightline](https://github.com/itchyny/lightline.vim)

##Usage
###Installation

Sample setting is using [NeoBundle](https://github.com/Shougo/neobundle.vim).  
If you want to use quickfix window, you can check [here](https://github.com/KazuakiM/vim-qfstatusline/blob/master/README.md#using-also-quickfix-window).

```vim
NeoBundle 'Shougo/vimproc'
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {
\    'watchdogs_checker/_' : {
\        'hook/close_quickfix/enable_exit':        1,
\        'hook/back_window/enable_exit':           0,
\        'hook/back_window/priority_exit':         1,
\        'hook/qfstatusline_update/enable_exit':   1,
\        'hook/qfstatusline_update/priority_exit': 2,},}
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'KazuakiM/vim-qfstatusline'
```

###default statusline setting

```vim
function! StatuslineUpdate()
    return qfstatusline#Update()
endfunction
let g:Qfstatusline#UpdateCmd = function('StatuslineUpdate')
set statusline=\ %{mode()}\ \|\ %t\ %m\ %r\ %h\ %w\ %q\ %{StatuslineUpdate()}%=\|\ %Y\ \|\ %{&fileformat}\ \|\ %{&fileencoding}\ 
```

###lightline.vim setting

```vim
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
\    'active': {
\        'left':  [['mode','paste'],['filename','qfstatusline']],
\        'right': [['lineinfo'],['percent'],['fileformat','fileencoding','filetype']]},
\    'component_expand': {'qfstatusline': 'qfstatusline#Update'},
\    'component_type':   {'qfstatusline': 'error'}}
let g:Qfstatusline#UpdateCmd = function('lightline#update')
```

####using also quickfix window

```vim
let g:quickrun_config = {
\    'watchdogs_checker/_' : {
\        'hook/back_window/enable_exit' :          1,
\        'hook/qfstatusline_update/enable_exit':   1,
\        'hook/qfstatusline_update/priority_exit': 1,},}
```

## Author

[KazuakiM](https://github.com/KazuakiM/)

## License

This software is released under the MIT License, see LICENSE.
