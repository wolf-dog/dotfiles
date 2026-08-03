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

-- cancel and return to normal mode
bind('v', '<C-j>', '<Esc>')
bind('o', '<C-j>', '<Esc>')
bind('i', '<C-j>', '<Esc>:<C-u>set iminsert=0<CR>', silent)
bind('c', '<C-j>', '<C-c>')
bind('s', '<C-j>', '<Esc>')

-- clear highlighting on last searched pattern
bind('n', '<C-j>', ':<C-u>nohlsearch<CR>', silent)

-- enable to undo
bind('i', '<C-w>', '<C-g>u<C-w>')
bind('i', '<C-u>', '<C-g>u<C-u>')

-- jump to match parens
bind('n', '<C-g>', '%')
bind('v', '<C-g>', '%')
bind('o', '<C-g>', '%')


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

-- quickref
bind('n', '<Space>:', ':<C-u>help quickref<CR>', silent)

-- search help about the word under the cursor
bind('n', "<Space>'", ':<C-u>help <C-r><C-w><CR>', silent)

-- toggle paste
bind('n', '<Space>"', ':<C-u>set paste!<CR>', silent)

-- search conflict marker
bind('n', '<Space>i', '/\\v[<=>]{7}<CR>', silent)
