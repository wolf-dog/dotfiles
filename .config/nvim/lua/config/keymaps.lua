local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

-- <BS> is the same as <C-h>
bind('n', '<BS>', '<C-h>')

-- switch ; and :
bind('n', ';', ':')
bind('n', ':', ';')
bind('v', ';', ':')
bind('v', ':', ';')
bind('o', ';', ':')
bind('o', ':', ';')

-- use screen lines normally
bind('n', 'j', 'gj')
bind('n', 'k', 'gk')
bind('n', 'gj', 'j')
bind('n', 'gk', 'k')
bind('v', 'j', 'gj')
bind('v', 'k', 'gk')
bind('v', 'gj', 'j')
bind('v', 'gk', 'k')
bind('o', 'j', 'gj')
bind('o', 'k', 'gk')
bind('o', 'gj', 'j')
bind('o', 'gk', 'k')

-- substitute
bind('n', '//', ':%s/')

-- yank to the end of the line
bind('n', 'Y', 'y$')

-- quit
bind('n', 'Q', ':<C-u>q<CR>')

-- select angle blacket <>
bind('v', 'ia', 'i>')
bind('v', 'aa', 'a>')
bind('o', 'ia', 'i>')
bind('o', 'aa', 'a>')

-- select curly blacket {}
bind('v', 'ic', 'i}')
bind('v', 'ac', 'a}')
bind('o', 'ic', 'i}')
bind('o', 'ac', 'a}')

-- select square blacket []
bind('v', 'is', 'i]')
bind('v', 'as', 'a]')
bind('o', 'is', 'i]')
bind('o', 'as', 'a]')

-- repeat the latest search and let current line at center of window
bind('n', 'n', 'nzz')
bind('n', 'N', 'Nzz')

-- when gg, move cursor to the first column
bind('n', 'gg', 'gg0')
bind('v', 'gg', 'gg0')
bind('o', 'gg', 'gg0')

-- repeat last command on every selected line
bind('v', '.', ':<C-u>normal.<CR>')

-- repeat macro on every selected line
bind('v', '@', ':<C-u>normal@<CR>')

-- repeat last f, t, F or T in opposite direction
bind('n', '\\', ',')
bind('v', '\\', ',')
bind('o', '\\', ',')


-----------------------
-- start with <Ctrl> --
-----------------------

-- input backspace with C-h
bind('n', '<C-h>', 'X')

-- move around like shell in command-line mode
bind('c', '<C-a>', '<Home>')
bind('c', '<C-f>', '<Right>')
bind('c', '<C-b>', '<Left>')

-- tab navigation
bind('n', '<C-n>', ':<C-u>tabnext<CR>', silent)
bind('n', '<C-p>', ':<C-u>tabprev<CR>', silent)

-- jump to the matching brace or bracket

-- use map, not noremap to refer the binds of matchit.vim
bind('n', '<C-g>', '%')
bind('v', '<C-g>', '%')
bind('o', '<C-g>', '%')

-- cancel and return to normal mode
bind('v', '<C-j>', '<Esc>')
bind('o', '<C-j>', '<Esc>')
bind('i', '<C-j>', '<Esc>:<C-u>set iminsert=0<CR>', silent)
bind('c', '<C-j>', '<C-c>')
bind('s', '<C-j>', '<Esc>')

-- clear highlighting on last searched pattern
bind('n', '<C-j>', ':<C-u>nohlsearch<CR>', silent)

-- switch to next window
bind('n', '<C-f>', '<C-w>w')

-- switch to last accessed window
bind('n', '<C-b>', '<C-w>p')

-- enable to undo
bind('i', '<C-w>', '<C-g>u<C-w>')
bind('i', '<C-u>', '<C-g>u<C-u>')

-- disable Ctrl-s
bind('n', '<C-s>', '<Nop>')

-- tag jump
bind('n', '<C-k>', 'g<C-]>')


------------------------
-- start with <Space> --
------------------------

-- disable <Space> to use it as the prefix key
bind('n', '<Space>', '<Nop>')
bind('v', '<Space>', '<Nop>')
bind('o', '<Space>', '<Nop>')

-- move to the first/last character
bind('n', '<Space>h', '^')
bind('n', '<Space>l', '$')
bind('v', '<Space>h', '^')
bind('v', '<Space>l', '$')
bind('o', '<Space>h', '^')
bind('o', '<Space>l', '$')

-- paste from the clipboard
bind('n', '<Space>p', '"+p')
bind('n', '<Space>P', '"+P')
bind('v', '<Space>p', '"+p')
bind('v', '<Space>P', '"+P')

-- yank to the clipboard
bind('n', '<Space>y', '"+y')
bind('n', '<Space>Y', '"+y$')
bind('v', '<Space>y', '"+y')

-- delete and yank to the clipboard
bind('n', '<Space>d', '"+d')
bind('n', '<Space>D', '"+D')
bind('v', '<Space>d', '"+d')
bind('v', '<Space>D', '"+D')

-- insert a new line in normal mode
bind('n', '<Space>o', 'o<Esc>')
bind('n', '<Space>O', 'O<Esc>')

-- insert text before the last character
bind('n', '<Space>a', '$i')

-- open a new tab
bind('n', '<Space>t', ':<C-u>tabnew<CR>', silent)

-- duplicate current tab
bind('n', '<Space>u', ':<C-u>tabnew %<CR>', silent)

-- search using very nomagic
bind('n', '<Space>/', '/\\V')
bind('n', '<Space>?', '?\\V')

-- substitute using very nomagic
bind('n', '<Space>//', ':<C-u>%s/\\V')

-- search for the word under the cursor
bind('n', '<Space>n', '*zz')

-- search backward for the word under the cursor
bind('n', '<Space>N', '#zz')

-- list the marks
bind('n', '<Space>m', ':<C-u>marks<CR>', silent)

-- change encodings and formats
bind('n', '<Space>e', '<Nop>')
bind('n', '<Space>ec', ':<C-u>setlocal fileencoding=cp932<CR>', silent)
bind('n', '<Space>ee', ':<C-u>setlocal fileencoding=euc-jp<CR>', silent)
bind('n', '<Space>eu', ':<C-u>setlocal fileencoding=utf-8<CR>', silent)
bind('n', '<Space>ei', ':<C-u>setlocal fileencoding=iso-2022-jp<CR>', silent)
bind('n', '<Space>ed', ':<C-u>setlocal fileformat=dos<CR>', silent)
bind('n', '<Space>ex', ':<C-u>setlocal fileformat=unix<CR>', silent)

-- move tab to next/previous
bind('n', '<Space><C-n>', ':<C-u>tabmove +1<CR>', silent)
bind('n', '<Space><C-p>', ':<C-u>tabmove -1<CR>', silent)

-- split window
bind('n', '<Space>s', ':<C-u>rightbelow split<CR>', silent)
bind('n', '<Space>v', ':<C-u>rightbelow vsplit<CR>', silent)

-- help
bind('n', '<Space>;', ':<C-u>help<Space>')

-- quickref
bind('n', '<Space>:', ':<C-u>help quickref<CR>', silent)

-- search help about the word under the cursor
bind('n', "<Space>'", ':<C-u>help <C-r><C-w><CR>', silent)

-- quick diff
bind('n', '<Space>cd', ':<C-u>diffthis<CR><C-w>p:<C-u>diffthis<CR><C-w>p', silent)

-- turn off diff mode in all windows
bind('n', '<Space>cq', ':<C-u>diffoff!<CR><C-w>p:<C-u>quit<CR>', silent)

-- diff
bind('n', '<Space>cs', ':<C-u>diffsplit<Space>')
bind('n', '<Space>cv', ':<C-u>vertical diffsplit<Space>')

-- turn off diff mode
bind('n', '<Space>cc', ':<C-u>diffoff<CR>', silent)

-- update diff
bind('n', '<Space>cu', ':<C-u>diffupdate<CR>', silent)

-- toggle paste
bind('n', '<Space>"', ':<C-u>set paste!<CR>', silent)

-- search conflict marker
bind('n', '<Space>i', '/\\v[<=>]{7}<CR>', silent)

-- LSP
bind('n', '<Space>kk', vim.lsp.buf.definition)
bind('n', '<Space>ka', vim.lsp.buf.code_action)
bind('n', '<Space>kd', vim.lsp.buf.document_symbol)
bind('n', '<Space>kf', vim.lsp.buf.format)
bind('n', '<Space>kh', vim.lsp.buf.hover)
bind('n', '<Space>kr', vim.lsp.buf.references)
bind('n', '<Space>kn', vim.lsp.buf.rename)
bind('n', '<Space>ks', vim.lsp.buf.signature_help)

bind('n', '<Space>jj', vim.diagnostic.open_float)
bind('n', '<Space>jq', vim.diagnostic.setqflist)
bind('n', '<Space>jn', vim.diagnostic.goto_next)
bind('n', '<Space>jp', vim.diagnostic.goto_prev)
