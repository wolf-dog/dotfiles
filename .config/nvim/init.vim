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
if empty(glob('~/.nvim/plugged'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.nvim/plugged')

Plug 'Shougo/vimproc.vim', {'dir': '~/.vim/plugged/vimproc.vim', 'do': 'make'}

" deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" denite
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/junkfile.vim'
Plug 'chemzqm/unite-location'
Plug 'kmnk/denite-dirmark'
Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'emonkak/vim-filetype-pukiwiki', { 'for': 'pukiwiki' }

" textobj-user
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-underscore'
Plug 'h1mesuke/textobj-wiw'
Plug 'thinca/vim-textobj-between'

" operator-user
Plug 'kana/vim-operator-user'
Plug 'emonkak/vim-operator-comment'
Plug 'rhysd/vim-operator-surround'

" development tools
Plug 'thinca/vim-ref'
Plug 'thinca/vim-quickrun'
Plug 'joonty/vdebug'
Plug 'osyo-manga/shabadou.vim'
Plug 'osyo-manga/vim-watchdogs'
Plug 'cohama/vim-hier'
Plug 'vim-scripts/gtags.vim'
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
Plug 'autozimu/LanguageClient-neovim', {
\ 'branch': 'next',
\ 'do': 'bash install.sh',
\ }
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

" editing
Plug 'junegunn/vim-easy-align'
Plug 'vim-scripts/sudo.vim'
Plug 'tpope/vim-speeddating'

" appearance
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'lambdalisue/gina.vim'

" fzf
if !empty(glob('~/.fzf'))
  Plug '~/.fzf'
  Plug 'junegunn/fzf.vim'
elseif !empty(glob('/usr/local/opt/fzf'))
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
endif

" colorschemes
Plug 'wolf-dog/sceaduhelm.vim'
Plug 'wolf-dog/lightline-sceaduhelm.vim'
" Plug 'wolf-dog/nighted.vim'
" Plug 'hzchirs/vim-material'
" Plug 'Dru89/vim-adventurous'
" Plug 'skielbasa/vim-material-monokai'
" Plug 'ajmwagar/vim-deus'
" Plug 'crater2150/vim-theme-chroma'
" Plug 'davb5/wombat256dave'
" Plug 'ltlollo/diokai'
" Plug 'NewProggie/NewProggie-Color-Scheme'
" Plug 'jacoborus/tender.vim'
" Plug 'sherifkandeel/vim-colors'
" Plug 'Marfisc/vorange'
" Plug 'roosta/vim-srcery'
" Plug 'vim-scripts/oceandeep'
" Plug 'Konstruktionist/vim'
" Plug 'KKPMW/moonshine-vim'
" Plug 'trevorrjohn/vim-obsidian'
" Plug 'geetarista/ego.vim'
" Plug 'mhartington/oceanic-next'
" Plug 'marcopaganini/termschool-vim-theme'
" Plug 'wellsjo/wellsokai.vim'
" Plug 'DrSpatula/vim-buddy'
" Plug 'zsoltf/vim-maui'
" Plug 'znake/znake-vim'
" Plug 'trusktr/seti.vim'
" Plug 'kreeger/benlight'
" Plug 'orthecreedence/void.vim'
" Plug 'CruizeMissile/Revolution.vim'
" Plug 'ajh17/SpaceGray.vim'
" Plug 'vim-scripts/miko'
" Plug 'freeo/vim-kalisi'
" Plug 'goatslacker/mango.vim'
" Plug 'sjl/badwolf'
" Plug 'morhetz/gruvbox'
" Plug 'w0ng/vim-hybrid'
" Plug 'cocopon/iceberg.vim'
" Plug 'noahfrederick/vim-hemisu'
" Plug 'romainl/Apprentice'
" Plug 'jordwalke/flatlandia'
" Plug 'Lokaltog/vim-distinguished'

" display color table
Plug 'guns/xterm-color-table.vim'

call plug#end()

" matchit
source $VIMRUNTIME/macros/matchit.vim
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

if executable("hw")
  set grepprg=hw\ --no-group\ --no-color
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
nnoremap <silent> [Leader]" :<C-u>set paste!<CR>
" Go to older quickfix list
nnoremap <silent> [Leader]qp :<C-u>colder<CR>
" Go to newer quickfix list
nnoremap <silent> [Leader]qn :<C-u>cnewer<CR>
" search conflict marker
nnoremap <silent> [Leader]i /\v[<=>]{7}<CR>
" grep
nnoremap [Leader]g :<C-u>grep<Space>
" grep the word under the cursor
nnoremap <silent> [Leader]r :<C-u>grep<Space><C-r><C-w><CR>
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
" disable syntax highlighting on short tags
let g:php_sql_heredoc = 0
let g:php_sql_nowdoc = 0
let g:php_html_in_heredoc = 0
let g:php_html_in_nowdoc = 0

" sh
" use bash by default
let g:is_bash = 1

" markdown
" disable concealing
let g:vim_markdown_conceal = 0

" json
" disable concealing
let g:vim_json_syntax_conceal = 0

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {
\   '_': ['LanguageClient', 'around', 'buffer', 'member'],
\ }

" denite
let s:menus = {}

let s:menus.shortcut = {
\ 'description': 'Various shortcuts'
\ }
let s:menus.shortcut.command_candidates = [
\   ['update plugins', 'PlugUpdate | PlugUpgrade'],
\   ['install plugins', 'PlugInstall'],
\   ['clean plugins', 'PlugClean'],
\   ['Unite Beautiful Attack', 'Denite colorscheme -post-action=open -mode=normal'],
\ ]

call denite#custom#var('menu', 'menus', s:menus)
call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
call denite#custom#option('_', {
\ 'auto_resume': 'true',
\ 'cursor_wrap': 'true',
\ 'highlight_matched_char': 'None',
\ 'highlight_matched_range': 'None',
\ 'highlight_mode_insert': 'WildMenu',
\ })

" fruzzy
let g:fruzzy#usenative = 0
let g:fruzzy#sortonempty = 0

" ref
" define path to php manual
let g:ref_phpmanual_path = expand('~/etc/man/php')

" indentLine
let g:indentLine_color_term = 60
let g:indentLine_color_gui = '#5f5f87'

" quickrun
let g:quickrun_config = {
\   '_' : {
\     'runner/vimproc/sleep': 50,
\     'runner/vimproc/updatetime': 100,
\   },
\   'python': {
\     'command': 'python3'
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

" gitgutter
hi GitGutterAdd          ctermfg=69  ctermbg=234 cterm=none guifg=#5f87ff guibg=#1c1c1c gui=none
hi GitGutterDelete       ctermfg=202 ctermbg=234 cterm=none guifg=#ff5f00 guibg=#1c1c1c gui=none
hi GitGutterChange       ctermfg=221 ctermbg=234 cterm=none guifg=#ffdf5f guibg=#1c1c1c gui=none
hi GitGutterChangeDelete ctermfg=221 ctermbg=234 cterm=none guifg=#ffdf5f guibg=#1c1c1c gui=none
let g:gitgutter_sign_added = '.'
let g:gitgutter_sign_modified = '.'
let g:gitgutter_sign_removed = '.'
let g:gitgutter_sign_removed_first_line = ':'
let g:gitgutter_sign_modified_removed = ':'
let g:gitgutter_map_keys = 0

" vdebug
let g:vdebug_options = {
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

" fzf
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'up': '~40%' }

" LanguageClient
let g:LanguageClient_diagnosticsEnable = 0
"--------------------------------------

"--------------------------------------
" plugin binds

" denite
noremap [denite] <Nop>
nmap s [denite]
" open file list
nnoremap <silent> [denite]s :<C-u>Denite file file:new<CR>
" open file list with current buffer directory
nnoremap <silent> [denite]d :<C-u>DeniteBufferDir file file:new<CR>
" open bookmarks
nnoremap <silent> [denite]a :<C-u>Denite dirmark<CR>
" add bookmarks
nnoremap <silent> [denite]A :<C-u>Denite dirmark/add<CR>
" open buffer list
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
" open recently used files list
nnoremap <silent> [denite]r :<C-u>Denite file_mru<CR>
" open junk file
nnoremap <silent> [denite]j :<C-u>Denite junkfile:new junkfile<CR>
" open register
nnoremap <silent> [denite]' :<C-u>Denite register<CR>
" open quickfix
nnoremap <silent> [denite]q :<C-u>Denite quickfix -post-action=open -mode=normal<CR>
" outline
nnoremap <silent> [denite]o :<C-u>Denite outline -post-action=open -mode=normal<CR>
" open menu
nnoremap <silent> [denite]f :<C-u>Denite menu:shortcut<CR>

autocmd FileType denite call s:denite_key_binds()
function! s:denite_key_binds() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')

  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')

  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')

  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')

  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'

  nnoremap <silent><buffer><expr> <C-s>
  \ denite#do_map('do_action', 'split')

  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')

  nnoremap <silent><buffer><expr> <C-g>
  \ denite#do_map('do_action', 'cd')

  nnoremap <silent><buffer><expr> <C-w>
  \ denite#do_map('move_up_path')

  nnoremap <silent><buffer><expr> a
  \ denite#do_map('do_action', 'add')
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

" easy-align
vmap <Leader>A <Plug>(EasyAlign)
vmap <Leader>aa <Plug>(EasyAlign)*=
vmap <Leader>at <Plug>(EasyAlign)*<Bar>
vmap <Leader>as <Plug>(EasyAlign)*<Space>
" intaractive easy-align
nmap <Leader>A <Plug>(EasyAlign)

" operator-comment
nmap <silent> <Leader>c <Plug>(operator-comment)
nmap <silent> <Leader>C <Plug>(operator-uncomment)

" operator-surround
nmap <silent> <Leader>sa <Plug>(operator-surround-append)
nmap <silent> <Leader>sd <Plug>(operator-surround-delete)
nmap <silent> <Leader>sr <Plug>(operator-surround-replace)

" gitgutter
nmap <silent> <Leader>hn <Plug>GitGutterNextHunk
nmap <silent> <Leader>hp <Plug>GitGutterPrevHunk
nmap <silent> <Leader>hh <Plug>GitGutterPreviewHunk
omap <silent> ih <Plug>GitGutterTextObjectInnerPending
omap <silent> ah <Plug>GitGutterTextObjectOuterPending
xmap <silent> ih <Plug>GitGutterTextObjectInnerVisual
xmap <silent> ah <Plug>GitGutterTextObjectOuterVisual

" gina
nnoremap <silent> <Leader>gb :<C-u>Gina blame<CR>
nnoremap <silent> <Leader>gd :<C-u>topleft Gina diff --opener=split<CR>
nnoremap <silent> <Leader>gl :<C-u>topleft Gina log --opener=split<CR>
nnoremap <silent> <Leader>gs :<C-u>topleft Gina status --opener=split<CR>
nnoremap <silent> <Leader>gr :Gina qrep! <C-r><C-w><CR>
nnoremap <Leader>gg :Gina qrep!<Space>
nnoremap <Leader>G :<C-u>Gina<Space>

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

" fzf
nnoremap <silent> <Leader>es :<C-u>FzfFiles<CR>
nnoremap <silent> <Leader>ee :<C-u>FzfGFiles<CR>

" language client
nnoremap <silent> <Leader>kk :<C-u>call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <Leader>kr :<C-u>call LanguageClient#textDocument_references()<CR>
"--------------------------------------

"--------------------------------------
" local settings
if filereadable(expand('~/.config/nvim/init_local.vim'))
  source ~/.config/nvim/init_local.vim
endif
