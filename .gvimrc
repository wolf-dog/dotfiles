" display {{{1
"--------------------------------------
set columns=100
set lines=50
set guicursor=a:ver10-Cursor-blinkon0
if has ('win32') || has ('win64')
    set guifont=Envy_Code_R:h10:cANSI
else
    set guifont=EnvyCodeMigu1M\ 12
endif
" disable all gui feature and use console dialogs
set guioptions= guioptions+=c

" disable the bell completely
set vb
set t_vb=
"--------------------------------------

