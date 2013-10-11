" core {{{1
"--------------------------------------
set nocompatible
" use english menu and messages
set langmenu=none
language messages C
" set user local directory
if has ('win32') || has('win64')
    let $VIMUSERDIR=$HOME.'/vimfiles'
else
    let $VIMUSERDIR=$HOME.'/.vim'
endif
"--------------------------------------

" NeoBundle {{{1
"--------------------------------------
if has ('vim_starting')
    set runtimepath& runtimepath+=$VIMUSERDIR/bundle/neobundle.vim/
endif
call neobundle#rc(expand('$VIMUSERDIR/bundle/'))

" plugins
let g:neobundle#types#git#default_protocol = 'git'
NeoBundle '://github.com/Shougo/neobundle.vim'
if has ('win32') || has ('win64')
" in windows, don't manage vimproc with NeoBundle
else
    NeoBundle '://github.com/Shougo/vimproc.vim', {
    \     'build' : {
    \         'cygwin' : 'make -f make_cygwin.mak',
    \         'mac'    : 'make -f make_mac.mak',
    \         'unix'   : 'make -f make_unix.mak',
    \     },
    \ }
endif

if ( has('lua') && (v:version > 703 || v:version == 703 && has('patch885')) )
    let s:neocomplete_available = 1
else
    let s:neocomplete_available = 0
endif

if ( s:neocomplete_available )
    NeoBundle '://github.com/Shougo/neocomplete.vim'
else
    NeoBundle '://github.com/Shougo/neocomplcache.vim'
endif

NeoBundle '://github.com/Shougo/unite.vim'
NeoBundle '://github.com/Shougo/unite-outline'
NeoBundle '://github.com/thinca/vim-ref'
NeoBundle '://github.com/Yggdroot/indentLine'
NeoBundle '://github.com/thinca/vim-quickrun'
NeoBundle '://github.com/h1mesuke/vim-alignta'
NeoBundle '://github.com/ChoiZ/vim-json'
NeoBundle '://github.com/scrooloose/syntastic'
NeoBundle '://github.com/jelera/vim-javascript-syntax'
NeoBundle '://github.com/tpope/vim-fugitive'
NeoBundle '://github.com/Shougo/junkfile.vim'
NeoBundle '://github.com/kana/vim-textobj-user'
NeoBundle '://github.com/kana/vim-textobj-line'
NeoBundle '://github.com/kana/vim-textobj-entire'
NeoBundle '://github.com/kana/vim-textobj-indent'
NeoBundle '://github.com/thinca/vim-textobj-between'
NeoBundle '://github.com/ujihisa/unite-colorscheme'
NeoBundle '://github.com/osyo-manga/unite-highlight'
NeoBundle '://github.com/itchyny/lightline.vim'
NeoBundle '://github.com/vim-scripts/sudo.vim'

" colorschemes
NeoBundle '://github.com/wolf-dog/nighted.vim'
NeoBundle '://github.com/wolf-dog/lightline-nighted.vim'
NeoBundle '://github.com/veloce/vim-aldmeris'
NeoBundle '://github.com/apeacox/vim-distinguished'
NeoBundle '://github.com/tomasr/molokai'

" display color table
NeoBundle '://github.com/guns/xterm-color-table.vim'

filetype plugin indent on
"--------------------------------------

" buffers and files handling, encodings {{{1
"--------------------------------------
set noautoread
set nobackup
set nohidden
" set current buffer's dir to base dir
set browsedir=buffer
" always use utf-8 inside Vim
set encoding=utf-8
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

" display {{{1
"--------------------------------------
"general {{{2
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

" status line, tab line {{{2
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

" tabs and indents {{{2
set cindent
set expandtab
set shiftround
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4

" colors, syntax highlighting {{{2
" always use the terminal can display 256 colors
set t_Co=256
syntax enable
" prevent overriding colorscheme on reloading
if !exists('g:colors_name')
    set background=dark
    colorscheme nighted
endif

"--------------------------------------

" input {{{1
"--------------------------------------
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

" searching, matching, tags {{{1
"--------------------------------------
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

" binds {{{1
"--------------------------------------
" no modifier or prefix {{{2
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
" indent more quickly
nnoremap > >>
nnoremap < <<
" use very magic by default
nnoremap / /\v
nnoremap ? ?\v
" shorthand of replace on all lines
nnoremap // :<C-u>%s/
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

" start with <Ctrl> {{{2
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
" repeat last command on every selected line
vnoremap . :<C-u>normal.<CR>
" repeat macro on every selected line
vnoremap @ :<C-u>normal@

" start with [Leader] {{{2
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
" default indent command
nnoremap [Leader]> >
nnoremap [Leader]< <
" paste from the clipboard
nnoremap [Leader]p "*p
nnoremap [Leader]P "*P
vnoremap [Leader]p "*p
vnoremap [Leader]P "*P
" paste from the 0 register
nnoremap [Leader]0p "0p
nnoremap [Leader]0P "0P
vnoremap [Leader]0p "0p
vnoremap [Leader]0P "0P
" yank to the clipboard
nnoremap [Leader]y "*y
nnoremap [Leader]Y "*y$
vnoremap [Leader]y "*y
" delete and yank to the clipboard
nnoremap [Leader]d "*d
nnoremap [Leader]D "*D
vnoremap [Leader]d "*d
vnoremap [Leader]D "*D
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
nnoremap [Leader]// :<C-u>s/
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
" close previous window
nnoremap <silent> [Leader]q <C-w>p:<C-u>quit<CR>
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

" start with <Leader> {{{2
" disable ',' to use it as the prefix key
let mapleader = ','
nnoremap , <Nop>
" open the preview window and jump to the tag under the cursor
" or show candidates if multiple tags found
nnoremap <Leader><Leader> <C-w>g}
" list the matches
nnoremap <silent> <Leader>l :<C-u>ptselect<CR>
" jump to the next match
nnoremap <silent> <Leader>n :<C-u>ptnext<CR>
" jump to the previous match
nnoremap <silent> <Leader>p :<C-u>ptprevious<CR>
" jump to the first match
nnoremap <silent> <Leader>N :<C-u>ptfirst<CR>
" jump to the last match
nnoremap <silent> <Leader>P :<C-u>ptlast<CR>
" close the preview window
nnoremap <silent> <Leader>j :<C-u>pclose<CR>
" read a new tag file
nnoremap <silent> <Leader>z :<C-u>set tags+=
" quick diff
nnoremap <silent> <Leader>dd :<C-u>diffthis<CR><C-w>p:<C-u>diffthis<CR><C-w>p
" turn off diff mode in all windows
nnoremap <silent> <Leader>dq :<C-u>diffoff!<CR><C-w>p:<C-u>quit<CR>
" diff
nnoremap <Leader>ds :<C-u>diffsplit<Space>
nnoremap <Leader>dv :<C-u>vertical diffsplit<Space>
" turn off diff mode
nnoremap <silent> <Leader>dc :<C-u>diffoff<CR>
" update diff
nnoremap <silent> <Leader>du :<C-u>diffupdate<CR>
"--------------------------------------

" autocmd {{{1
"--------------------------------------
" augroup for all autocmd in this .vimrc
augroup vimrc-autocmd
    autocmd!
augroup END

" always use this format options regardless of the file type
autocmd vimrc-autocmd FileType *
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
autocmd vimrc-autocmd BufReadPost *
\ if &modifiable && !search('[^\x00-\x7F]', 'cnw')
    \ | setlocal fileencoding=
\ | endif
"--------------------------------------

" plugins, filetype settings {{{1
"--------------------------------------
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
call unite#set_profile('default', 'ignorecase', 1)
call unite#set_profile('default', 'smartcase', 0)
let g:unite_enable_start_insert = 1
" unite menu
let g:unite_source_menu_menus = {
\     'shortcut' : {
\         'command_candidates' : [
\             ['NeoBundle', 'Unite neobundle'],
\             ['NeoBundleUpdate', 'Unite neobundle/update'],
\             ['NeoBundleCheck', 'NeoBundleCheck'],
\             ['NeoBundleClean', 'NeoBundleClean'],
\             ['NeoBundleInstall', 'NeoBundleInstall'],
\             [
\                 'edit .vimrc',
\                 'execute "tabedit " . resolve(expand($MYVIMRC))'
\             ],
\             [
\                 'edit .gvimrc',
\                 'execute "tabedit " . resolve(expand($MYGVIMRC))'
\             ],
\             ['outline', 'Unite outline'],
\             ['highlight', 'Unite highlight'],
\             ['output map', 'Unite output:map|map!|lmap'],
\             ['output message', 'Unite output:message'],
\             ['output version', 'Unite output:version'],
\             ['Unite Beautiful Attack', 'Unite colorscheme -auto-preview'],
\         ],
\     },
\ }

" ref
" define path to php manual
if has('win32') || ('win64')
    let s:lynx = 'D:/usr/local/share/lynx/lynx.exe'
    let s:lynx_cfg = 'D:/usr/local/share/lynx/lynx.cfg'
    let g:ref_phpmanual_path = 'D:/usr/local/man/php'
    let g:ref_phpmanual_cmd = s:lynx.' -cfg='.s:lynx_cfg.' -dump -nonumbers %s'
else
    let g:ref_phpmanual_path = '/usr/local/man/php'
endif

" indentLine
let g:indentLine_color_term = 236
let g:indentLine_color_gui = '#303030'

" quickrun
let g:quickrun_config = {}
let g:quickrun_config = {
\     '_' : {
\         'runner/vimproc/sleep': 50,
\         'runner/vimproc/updatetime': 100,
\     }
\ }
" if running on cygwin, replace cygwin-style path to windows-style path
if has('win32unix')
    let g:quickrun_config = {
\       '_' : {
\           'exec': '%c %o %a < `cygpath -m %s`'
\       }
\   }
endif

" syntastic
let g:syntastic_check_on_wq = 0

" lightline
let g:lightline = {}
let g:lightline = {
\   'colorscheme': 'nighted',
\   'enable': {
\       'statusline': 1,
\       'tabline': 0
\   },
\   'active': {
\       'left': [ ['mode', 'paste' ],
\                 [ 'readonly', 'absolutepath', 'modified' ] ]
\   }
\ }
"--------------------------------------

" plugin binds {{{1
"--------------------------------------
" unite
noremap [unite] <Nop>
nmap s [unite]
" open file list
nnoremap <silent> [unite]s :<C-u>Unite file file/new<CR>
" open file list with current buffer directory
nnoremap <silent> [unite]d :<C-u>UniteWithBufferDir file file/new<CR>
" open bookmarks
nnoremap <silent> [unite]a :<C-u>Unite bookmark<CR>
" open buffer list
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" open recently used file list
nnoremap <silent> [unite]r :<C-u>Unite file_mru<CR>
" open junk file
nnoremap <silent> [unite]j :<C-u>Unite junkfile/new junkfile<CR>
" open register
nnoremap <silent> [unite]' :<C-u>Unite register<CR>
" grep
nnoremap [unite]g :<C-u>Unite -no-quit grep:
" grep in current directory recursively
nnoremap [unite]G :<C-u>Unite -no-quit grep:./:-r:
" open menu:shortcut
nnoremap <silent> [unite]f :<C-u>Unite menu:shortcut<CR>

" open with horizontally split window
autocmd vimrc-autocmd FileType unite nnoremap
\ <silent> <buffer> <expr> <C-k> unite#do_action('below')
autocmd vimrc-autocmd FileType unite inoremap
\ <silent> <buffer> <expr> <C-k> unite#do_action('below')
" open with vertically split window
autocmd vimrc-autocmd FileType unite nnoremap
\ <silent> <buffer> <expr> <C-l> unite#do_action('right')
autocmd vimrc-autocmd FileType unite inoremap
\ <silent> <buffer> <expr> <C-l> unite#do_action('right')
" add to bookmark
autocmd vimrc-autocmd FileType unite nnoremap
\ <silent> <buffer> <expr> <C-a> unite#do_action('bookmark')
autocmd vimrc-autocmd FileType unite inoremap
\ <silent> <buffer> <expr> <C-a> unite#do_action('bookmark')
" list actions
autocmd vimrc-autocmd FileType unite nmap
\ <silent> <buffer> <C-r> <Plug>(unite_choose_action)
autocmd vimrc-autocmd FileType unite imap
\ <silent> <buffer> <C-r> i_<Plug>(unite_choose_action)
" quit unite window
autocmd vimrc-autocmd FileType unite nnoremap
\ <silent> <buffer> <C-j> :<C-u>quit<CR>
autocmd vimrc-autocmd FileType unite inoremap
\ <silent> <buffer> <C-j> <Esc>

" ref
nnoremap <Space>r :<C-u>Ref phpmanual<Space>

" quickrun
nnoremap <silent> [Leader]x :<C-u>QuickRun<CR>

" alignta
vnoremap          [Leader]A :Alignta<Space>
vnoremap <silent> [Leader]aa :Alignta =>\=<CR>
vnoremap <silent> [Leader]as :Alignta <-- =>\=<CR>

" syntastic
nnoremap [Leader]c :<C-u>SyntasticCheck<CR>

" fugitive
nnoremap          <Leader>gi :<C-u>Git<Space>
nnoremap <silent> <Leader>gl :<C-u>Glog<CR>
nnoremap <silent> <Leader>gs :<C-u>Gstatus<CR>
nnoremap <silent> <Leader>gc :<C-u>Gcommit<CR>
nnoremap <silent> <Leader>gw :<C-u>Gwrite<CR>
nnoremap <silent> <Leader>gb :<C-u>Gblame<CR>
nnoremap <silent> <Leader>gd :<C-u>Gsdiff<CR>
nnoremap <silent> <Leader>gh :<C-u>Gsdiff HEAD^<CR>
nnoremap <silent> <Leader>gg :<C-u>Ggrep<CR>
"--------------------------------------

