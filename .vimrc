"--------------------------------------
" core

" always use utf-8 inside Vim
set encoding=utf-8
scriptencoding utf-8
" use english menu and messages
set langmenu=none
language messages C
"--------------------------------------

"--------------------------------------
" plugins

" set user local directory
let $DEINDIR=expand('~/.cache/dein')
let g:dein#types#git#default_protocol='ssh'

if has ('vim_starting')
  set runtimepath^=$DEINDIR/repos/github.com/Shougo/dein.vim
endif
call dein#begin(expand($DEINDIR))

call dein#add('/Shougo/dein.vim')

call dein#add('/Shougo/vimproc.vim', {'build': 'make'})

" neocomplete, neocomplcache
if ( has('lua') && (v:version > 703 || v:version == 703 && has('patch885')) )
  let s:neocomplete_available = 1
else
  let s:neocomplete_available = 0
endif
if ( s:neocomplete_available )
  call dein#add('/Shougo/neocomplete.vim')
else
  call dein#add('/Shougo/neocomplcache.vim')
endif

" unite
call dein#add('/Shougo/unite.vim')
call dein#add('/Shougo/neomru.vim')
call dein#add('/Shougo/unite-outline')
call dein#add('/osyo-manga/unite-highlight')
call dein#add('/ujihisa/unite-colorscheme')
call dein#add('/osyo-manga/unite-quickfix')
call dein#add('/Shougo/junkfile.vim')

" syntax
call dein#add('/wolf-dog/vim-json')
call dein#add('/jelera/vim-javascript-syntax')
call dein#add('/emonkak/vim-filetype-pukiwiki')
call dein#add('/kchmck/vim-coffee-script')

" textobj-user
call dein#add('/kana/vim-textobj-user')
call dein#add('/kana/vim-textobj-line')
call dein#add('/kana/vim-textobj-entire')
call dein#add('/kana/vim-textobj-indent')
call dein#add('/kana/vim-textobj-underscore')
call dein#add('/h1mesuke/textobj-wiw')
call dein#add('/thinca/vim-textobj-between')

" operator-user
call dein#add('/kana/vim-operator-user')
call dein#add('/osyo-manga/vim-operator-alignta')
call dein#add('/emonkak/vim-operator-comment')
call dein#add('/rhysd/vim-operator-surround')

" development tools
call dein#add('/thinca/vim-ref')
call dein#add('/thinca/vim-quickrun')
call dein#add('/joonty/vdebug')
call dein#add('/osyo-manga/shabadou.vim')
call dein#add('/osyo-manga/vim-watchdogs')
call dein#add('/cohama/vim-hier')
call dein#add('/vim-scripts/gtags.vim')

" colorschemes
call dein#add('/wolf-dog/nighted.vim')
call dein#add('/wolf-dog/lightline-nighted.vim')
call dein#add('/wolf-dog/sceaduhelm.vim')
call dein#add('/wolf-dog/lightline-sceaduhelm.vim')
call dein#add('/veloce/vim-aldmeris')
call dein#add('/apeacox/vim-distinguished')
call dein#add('/tomasr/molokai')
call dein#add('/croaker/mustang-vim')

" display color table
call dein#add('/guns/xterm-color-table.vim')

" misc.
call dein#add('/Yggdroot/indentLine')
call dein#add('/h1mesuke/vim-alignta')
call dein#add('/tpope/vim-fugitive')
call dein#add('/itchyny/lightline.vim')
call dein#add('/vim-scripts/sudo.vim')

call dein#end()

filetype plugin indent on
"--------------------------------------

"--------------------------------------
" buffers and files handling, encodings

set noautoread
set nobackup
set nohidden
" set current buffer's dir to base dir
set browsedir=buffer
" detect ordinary encodings
" of course, utf-8 contains all characters in latin1
" so if fileencoding is set to latin1, something is wrong ...
" possibly unlisted encoding is used
set fileencodings=ucs-bom,iso-2022-jp,utf-8,euc-jp,cp932,latin1
" always use LF for eol by default
set fileformat=unix
" detect ordinary eol formats
set fileformats=unix,dos,mac
" always use utf-8 inside the terminal
set termencoding=utf-8
"--------------------------------------

"--------------------------------------
" display

"--------------------------------------
" general

set list
set listchars=tab:\|\-,trail:<
set number
set ruler
" display doublewidth char correctly
set ambiwidth=double
" always show the last line of the file, not @
set display=lastline
" open all folds when starting to edit another buffer
set foldlevelstart=99
" use markers for folding
set foldmethod=marker
" let the cursor keep 3 lines away from edge of the window
set scrolloff=3
" disable intro message
set shortmess& shortmess+=I
" show (partial) command in the last line of the screen
set showcmd
" set title of the window
set title

" status line, tab line
" always show the status line
set laststatus=2
" show fileencoding (or internal encoding) in the status line
let &statusline = ''
let &statusline .= '%<%f %h%m%r%w'
let &statusline .= '%='
let &statusline .= '[%{&l:fileencoding == "" ? &encoding : &l:fileencoding}]'
let &statusline .= ' %-14.(%l,%c%V%) %P'
" always show the tabline
if v:version >= 700
  set showtabline=2
endif

" tabs and indents
set cindent
set expandtab
set shiftround
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2

" colors, syntax highlighting
" always use the terminal can display 256 colors
set t_Co=256
syntax enable
" prevent overriding colorscheme on reloading
if !exists('g:colors_name')
  set background=dark
  colorscheme sceaduhelm
endif
"--------------------------------------

"--------------------------------------
" input

" allow backspace to delete anything
set backspace=indent,eol,start
" disable turning on IME automatically
set iminsert=0
set imsearch=0
set noimcmdline
" keep the cursor column after several move commands
set nostartofline
" increment/decrement only digit and hex
set nrformats=hex
" reduce waiting time for a keycode to 50 milliseconds
set ttimeoutlen=50
" allow virtualedit in visual block mode
set virtualedit& virtualedit+=block
"--------------------------------------

"--------------------------------------
" searching, matching, tags

set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan
nohlsearch
" match <>
set matchpairs& matchpairs+=<:>
" prevent jumping to the matching paren
set matchtime=0
" show the matching brace
set showmatch
" search tags from ancestor directories
set tags& tags+=./tags;
" use command-line completion
set wildmenu
set wildmode=list:longest,full
if ( v:version >= 703)
  set wildignorecase
endif

"--------------------------------------
" binds

" no modifier or prefix
" <BS> is the same as <C-h>
nmap <BS> <C-h>
" switch ; and :
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
onoremap ; :
onoremap : ;
" use screen lines normally
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k
onoremap j gj
onoremap k gk
onoremap gj j
onoremap gk k
" use very magic by default
nnoremap / /\v
nnoremap ? ?\v
" shorthand of replace using very magic
nnoremap // :<C-u>%s/\v
" yank to the end of the line
nnoremap Y y$
" quit
nnoremap Q :<C-u>q<CR>
" select angle blacket <>
vnoremap ia i>
vnoremap aa a>
onoremap ia i>
onoremap aa a>
" select curly blacket {}
vnoremap ic i}
vnoremap ac a}
onoremap ic i}
onoremap ac a}
" select square blacket []
vnoremap is i]
vnoremap as a]
onoremap is i]
onoremap as a]
" repeat the latest search and let current line at center of window
nnoremap n nzz
nnoremap N Nzz
" when gg, move cursor to the first column
nnoremap gg gg0
vnoremap gg gg0
onoremap gg gg0
" repeat last command on every selected line
vnoremap . :<C-u>normal.<CR>
" repeat macro on every selected line
vnoremap @ :<C-u>normal@
" repeat last f, t, F or T in opposite direction
nnoremap \ ,
vnoremap \ ,
onoremap \ ,

" start with <Ctrl>
" input backspace with C-h
nnoremap <C-h> X
" move around like shell in command-line mode
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
" tab navigation
nnoremap <silent> <C-n> :<C-u>tabnext<CR>
nnoremap <silent> <C-p> :<C-u>tabprev<CR>
" jump to the matching brace or bracket
" use map, not noremap to refer the binds of matchit.vim
nmap <C-g> %
vmap <C-g> %
omap <C-g> %
" cancel and return to normal mode
vnoremap <C-j> <Esc>
onoremap <C-j> <Esc>
inoremap <silent> <C-j> <Esc>:<C-u>set iminsert=0<CR>
cnoremap <C-j> <C-c>
" clear highlighting on last searched pattern
nnoremap <silent> <C-j> :<C-u>nohlsearch<CR>
" switch to next window
nnoremap <C-f> <C-w>w
" switch to last accessed window
nnoremap <C-b> <C-w>p
" jump to the tag under the cursor,
" or show candidates if multiple tags found
nnoremap <C-k> g<C-]>
" enable to undo
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
" disable Ctrl-s
nnoremap <C-s> <Nop>
" :HierStop on Ctrl-l
nnoremap <silent> <C-l> <C-l>:<C-u>HierStop<CR>

" start with [Leader]
" disable <Space> to use it as the prefix key
noremap [Leader] <Nop>
nmap <Space> [Leader]
vmap <Space> [Leader]
omap <Space> [Leader]
" move to the first/last character
nnoremap [Leader]h ^
nnoremap [Leader]l $
vnoremap [Leader]h ^
vnoremap [Leader]l $
onoremap [Leader]h ^
onoremap [Leader]l $
" paste from the clipboard
nnoremap [Leader]p "+p
nnoremap [Leader]P "+P
vnoremap [Leader]p "+p
vnoremap [Leader]P "+P
" yank to the clipboard
nnoremap [Leader]y "+y
nnoremap [Leader]Y "+y$
vnoremap [Leader]y "+y
" delete and yank to the clipboard
nnoremap [Leader]d "+d
nnoremap [Leader]D "+D
vnoremap [Leader]d "+d
vnoremap [Leader]D "+D
" insert a new line in normal mode
nnoremap [Leader]o o<Esc>
nnoremap [Leader]O O<Esc>
" insert text before the last character
nnoremap [Leader]a $i
" open a new tab
nnoremap <silent> [Leader]t :<C-u>tabnew<CR>
" duplicate current tab
nnoremap <silent> [Leader]u :<C-u>tabnew %<CR>
" search using very nomagic
nnoremap [Leader]/ /\V
nnoremap [Leader]? ?\V
" shorthand of replace
nnoremap [Leader]// :<C-u>%s/
" search for the word under the cursor
nnoremap [Leader]n *zz
" search backward for the word under the cursor
nnoremap [Leader]N #zz
" list the marks
nnoremap <silent> [Leader]m :<C-u>marks<CR>
" change encodings and formats
nnoremap [Leader]e <Nop>
nnoremap <silent> [Leader]ec :<C-u>setlocal fileencoding=cp932<CR>
nnoremap <silent> [Leader]ee :<C-u>setlocal fileencoding=euc-jp<CR>
nnoremap <silent> [Leader]eu :<C-u>setlocal fileencoding=utf-8<CR>
nnoremap <silent> [Leader]ei :<C-u>setlocal fileencoding=iso-2022-jp<CR>
nnoremap <silent> [Leader]ed :<C-u>setlocal fileformat=dos<CR>
nnoremap <silent> [Leader]ex :<C-u>setlocal fileformat=unix<CR>
" move tab to next/previous
nnoremap <silent> [Leader]<C-n> :<C-u>tabmove +1<CR>
nnoremap <silent> [Leader]<C-p> :<C-u>tabmove -1<CR>
" split window
nnoremap <silent> [Leader]s :<C-u>rightbelow split<CR>
nnoremap <silent> [Leader]v :<C-u>rightbelow vsplit<CR>
" help
nnoremap [Leader]; :<C-u>help<Space>
" quickref
nnoremap <silent> [Leader]: :<C-u>help quickref<CR>
" search help about the word under the cursor
nnoremap <silent> [Leader]' :<C-u>help <C-r><C-w><CR>
" source .vimrc
nnoremap <silent> [Leader]= :<C-u>source $MYVIMRC<CR>
" source .gvimrc
nnoremap <silent> [Leader]+ :<C-u>source $MYGVIMRC<CR>
" open the preview window and jump to the tag under the cursor
" or show candidates if multiple tags found
nnoremap [Leader]ff <C-w>g}
" list the matches
nnoremap <silent> [Leader]fl :<C-u>ptselect<CR>
" jump to the next match
nnoremap <silent> [Leader]fn :<C-u>ptnext<CR>
" jump to the previous match
nnoremap <silent> [Leader]fp :<C-u>ptprevious<CR>
" jump to the first match
nnoremap <silent> [Leader]fN :<C-u>ptfirst<CR>
" jump to the last match
nnoremap <silent> [Leader]fP :<C-u>ptlast<CR>
" close the preview window
nnoremap <silent> [Leader]fj :<C-u>pclose<CR>
" quick diff
nnoremap <silent> [Leader]cd :<C-u>diffthis<CR><C-w>p:<C-u>diffthis<CR><C-w>p
" turn off diff mode in all windows
nnoremap <silent> [Leader]cq :<C-u>diffoff!<CR><C-w>p:<C-u>quit<CR>
" diff
nnoremap [Leader]cs :<C-u>diffsplit<Space>
nnoremap [Leader]cv :<C-u>vertical diffsplit<Space>
" turn off diff mode
nnoremap <silent> [Leader]cc :<C-u>diffoff<CR>
" update diff
nnoremap <silent> [Leader]cu :<C-u>diffupdate<CR>
" toggle paste
nnoremap <silent> [Leader]g :<C-u>set paste!<CR>
" Go to older quickfix list
nnoremap <silent> [Leader]qp :<C-u>colder<CR>
" Go to newer quickfix list
nnoremap <silent> [Leader]qn :<C-u>cnewer<CR>
" search conflict marker
nnoremap <silent> [Leader]i /\v[<=>]{7}<CR>
"--------------------------------------

"--------------------------------------
" autocmd

augroup vimrc-file
  autocmd!

  " always use this format options regardless of the file type
  autocmd FileType *
  \ if ( v:version >= 703)
  \ | setlocal formatoptions&
  \ formatoptions-=t formatoptions-=c
  \ formatoptions+=r formatoptions+=M formatoptions+=j
  \ | else
  \ | setlocal formatoptions&
  \ formatoptions-=t formatoptions-=c
  \ formatoptions+=r formatoptions+=M
  \ | endif

  " set fileencoding to empty (use default encoding)
  " when buffer only contains ASCII characters
  autocmd BufReadPost *
  \ if &modifiable && !search('[^\x00-\x7F]', 'cnw')
  \ | setlocal fileencoding=
  \ | endif
augroup END

augroup vimrc-highlight
  autocmd!

  " highlight ideographic-space
  autocmd VimEnter,ColorScheme *
  \ highlight IdeographicSpace ctermbg=Red guibg=Red
  autocmd VimEnter,WinEnter *
  \ let w:match_additional = matchadd('IdeographicSpace', '\%u3000')
augroup END
"--------------------------------------

"--------------------------------------
" plugins, filetype settings

" PHP
" enable sql syntax highlighting in the php strings
let g:php_sql_query = 1
" enable html syntax highlighting in the php strings
let g:php_htmlInStrings = 1
" disable syntax highlighting on short tags
let g:php_noShortTags = 1
" enable class and function folding
let g:php_folding = 1

" sh
" use bash by default
let g:is_bash = 1

if ( s:neocomplete_available )
  " neocomplete
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#max_list = 20
  let g:neocomplete#disable_auto_complete = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_fuzzy_completion = 0
  let g:neocomplete#enable_refresh_always = 0
else
  " neocomplcache
  let g:neocomplcache#enable_at_startup = 1
  let g:neocomplcache#max_list = 20
  let g:neocomplcache#disable_auto_complete = 1
  let g:neocomplcache#enable_smart_case = 1
endif

" unite
call unite#set_profile('default', 'context', {
\   'ignorecase': 1,
\   'smartcase': 0
\ })
let g:unite_enable_start_insert = 1
" unite menu
let g:unite_source_menu_menus = {
\   'shortcut' : {
\     'command_candidates' : [
\       ['DeinUpdate', 'execute "call dein#update()"'],
\       ['DeinCheck', 'execute "call dein#check_install()"'],
\       ['DeinInstall', 'execute "call dein#install()"'],
\       [
\         'edit .vimrc',
\         'execute "tabedit " . resolve(expand($MYVIMRC))'
\       ],
\       [
\         'edit .gvimrc',
\         'execute "tabedit " . resolve(expand($MYGVIMRC))'
\       ],
\       ['highlight', 'Unite highlight -no-start-insert'],
\       ['output map', 'Unite output:map|map!|lmap'],
\       ['output message', 'Unite output:message'],
\       ['output version', 'Unite output:version'],
\       ['Unite Beautiful Attack', 'Unite colorscheme -auto-preview -no-start-insert'],
\     ],
\   },
\ }

" ref
" define path to php manual
let g:ref_phpmanual_path = expand('~/usr/local/etc/man/php')

" indentLine
let g:indentLine_setColors = 0
let g:indentLine_color_term = 60
let g:indentLine_color_gui = '#5f5f87'
let g:indentLine_faster = 1
let g:indentLine_setConceal = 0

" quickrun
let g:quickrun_config = {
\   '_' : {
\     'runner/vimproc/sleep': 50,
\     'runner/vimproc/updatetime': 100,
\   }
\ }
" if running on cygwin, replace cygwin-style path to windows-style path
if has('win32unix')
  let g:quickrun_config = {
\     '_' : {
\       'exec': '%c %o %a < `cygpath -m %s`'
\     }
\   }
endif

" vdebug
let g:vdebug_options = {
\   'port': $XDEBUG_PORT,
\   'marker_default' : '.',
\   'marker_closed_tree' : '+',
\   'marker_open_tree' : '-',
\ }

" lightline
let g:lightline = {
\   'colorscheme': 'sceaduhelm',
\   'enable': {
\     'statusline': 1,
\     'tabline': 1
\   },
\   'tabline_subseparator': {
\     'left': '',
\     'right': ''
\   },
\   'active': {
\     'left': [ ['mode', 'paste' ],
\         [ 'readonly', 'absolutepath', 'modified' ] ]
\   }
\ }

" watchdogs
let g:watchdogs_check_BufWritePost_enable = 1
"--------------------------------------

"--------------------------------------
" plugin binds

" unite
noremap [unite] <Nop>
nmap s [unite]
" open file list
nnoremap <silent> [unite]s :<C-u>Unite file file/new directory/new<CR>
" open file list with current buffer directory
nnoremap <silent> [unite]d :<C-u>UniteWithBufferDir file file/new directory/new<CR>
" open bookmarks
nnoremap <silent> [unite]a :<C-u>Unite bookmark<CR>
" open buffer list
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" open recently used files list
nnoremap <silent> [unite]r :<C-u>Unite neomru/file<CR>
" open recently used directories list
nnoremap <silent> [unite]t :<C-u>Unite -default-action=lcd neomru/directory<CR>
" open junk file
nnoremap <silent> [unite]j :<C-u>Unite junkfile/new junkfile<CR>
" open register
nnoremap <silent> [unite]' :<C-u>Unite register<CR>
" open quickfix
nnoremap <silent> [unite]q :<C-u>Unite -no-start-insert -no-quit quickfix<CR>
" outline
nnoremap <silent> [unite]o :<C-u>Unite -no-start-insert -no-quit outline<CR>
" open menu:shortcut
nnoremap <silent> [unite]f :<C-u>Unite menu:shortcut<CR>

augroup vimrc-unite
  autocmd!
  autocmd FileType unite call s:unite_settings()
augroup END

function! s:unite_settings()
  " open with horizontally split window
  nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('below')
  inoremap <silent> <buffer> <expr> <C-s> unite#do_action('below')
  " open with vertically split window
  nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('right')
  inoremap <silent> <buffer> <expr> <C-v> unite#do_action('right')
  " add to bookmark
  nnoremap <silent> <buffer> <expr> <C-a> unite#do_action('bookmark')
  inoremap <silent> <buffer> <expr> <C-a> unite#do_action('bookmark')
  " delete backward path
  imap <silent> <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " quit unite window
  nnoremap <silent> <buffer> <C-j> :<C-u>quit<CR>
  inoremap <silent> <buffer> <C-j> <Esc>
endfunction

" start with <Leader>
" disable ',' to use it as the prefix key
let g:mapleader = ','
nnoremap , <Nop>

" ref
nnoremap <Leader>rph :<C-u>Ref phpmanual<Space>

" indentLine
nnoremap <Leader>t :<C-u>IndentLinesToggle<CR>

" quickrun
nnoremap <silent> <Leader>x :<C-u>QuickRun<CR>
nnoremap          <Leader>X :<C-u>QuickRun -args<Space>

" alignta
vnoremap          <Leader>A :<C-u>Alignta<Space>
vnoremap <silent> <Leader>aa :<C-u>Alignta =>\=<CR>
vnoremap <silent> <Leader>as :<C-u>Alignta 0 -r \ [^\ ]<CR>
" operator-alignta
nmap          <Leader>A <Plug>(operator-alignta)
nmap <silent> <Leader>aa <Plug>(operator-alignta-preset) =>\=<CR>
nmap <silent> <Leader>as <Plug>(operator-alignta-preset) 0 -r \ [^\ ]<CR>

" operator-comment
nmap <silent> <Leader>c <Plug>(operator-comment)
nmap <silent> <Leader>C <Plug>(operator-uncomment)

" operator-surround
nmap <silent> <Leader>sa <Plug>(operator-surround-append)
nmap <silent> <Leader>sd <Plug>(operator-surround-delete)
nmap <silent> <Leader>sr <Plug>(operator-surround-replace)

" fugitive
nnoremap          <Leader>gi :<C-u>Git<Space>
nnoremap <silent> <Leader>gl :<C-u>Glog<CR>
nnoremap <silent> <Leader>gs :<C-u>Gstatus<CR>
nnoremap <silent> <Leader>gc :<C-u>Gcommit -v<CR>
nnoremap <silent> <Leader>gw :<C-u>Gwrite<CR>
nnoremap <silent> <Leader>gb :<C-u>Gblame<CR>
nnoremap <silent> <Leader>gd :<C-u>Gsdiff<CR>
nnoremap <silent> <Leader>gh :<C-u>Gsdiff HEAD^<CR>
nnoremap          <Leader>gg :<C-u>Ggrep<Space>

" vdebug
let g:vdebug_keymap = {
\   'run'               : '<Leader>ff',
\   'run_to_cursor'     : '<Leader>fr',
\   'step_over'         : '<Leader>fl',
\   'step_into'         : '<Leader>fi',
\   'step_out'          : '<Leader>fo',
\   'close'             : '<Leader>fj',
\   'detach'            : '<Leader>fd',
\   'set_breakpoint'    : '<Leader>fb',
\   'get_context'       : '<Leader>fc',
\   'eval_under_cursor' : '<Leader>fx',
\   'eval_visual'       : '<Leader>fv',
\ }

" watchdogs
nnoremap <silent> <Leader>w :<C-u>WatchdogsRun<CR>

" gtags
let g:Gtags_OpenQuickfixWindow = 0
nnoremap <silent> <C-k> :<C-u>GtagsCursor<CR>
nnoremap          <Leader>dd :<C-u>Gtags<Space>
nnoremap <silent> <Leader>dr :<C-u>Gtags -r <C-r><C-w><CR>
nnoremap <silent> <Leader>dn :<C-u>cn<CR>
nnoremap <silent> <Leader>dp :<C-u>cp<CR>
"--------------------------------------

