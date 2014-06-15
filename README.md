#vim-qfstatusline

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

##Installation
###Sample setting.

Sample setting is using [NeoBundle](https://github.com/Shougo/neobundle.vim).  
This setting is not working. However it's plugins setting hint.  
Please check Requirement plugins's READE.md. thanx :)

```vim
NeoBundle 'Shougo/vimproc'
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {
\    'watchdogs_checker/_' : {
\        'hook/qfstatusline_update/enable_exit':   1,
\        'hook/qfstatusline_update/priority_exit': 4,},}
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'KazuakiM/vim-qfstatusline'

"Recommends plugin setting
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
\    'active': {
\        'right': [ [ 'qfstatusline', 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ],},
\    'component_expand': {
\        'qfstatusline': 'qfstatusline#Update',},
\    'component_type': {
\        'qfstatusline': 'error',},}

let g:Qfstatusline#UpdateCmd = function('lightline#update')
```

## Author

[KazuakiM](https://github.com/KazuakiM/)

## License

This software is released under the MIT License, see LICENSE.
