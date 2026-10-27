local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

-- quit
bind('n', 'Q', ':<C-u>q<CR>')


-----------------------
-- start with <Ctrl> --
-----------------------

-- tab navigation
bind('n', '<C-n>', ':<C-u>tabnext<CR>', silent)
bind('n', '<C-p>', ':<C-u>tabprev<CR>', silent)

-- switch to next window
bind('n', '<C-f>', '<C-w>w')

-- switch to last accessed window
bind('n', '<C-b>', '<C-w>p')

-- disable Ctrl-s
bind('n', '<C-s>', '<Nop>')

-- tag jump
bind('n', '<C-k>', 'g<C-]>')

-- leave terminal mode
bind('t', '<C-j>', '<C-\\><C-n>')


------------------------
-- start with <Space> --
------------------------

-- open a new tab
bind('n', '<Space>t', ':<C-u>tabnew<CR>', silent)

-- duplicate current tab
bind('n', '<Space>u', ':<C-u>tabnew %<CR>', silent)

-- move tab to next/previous
bind('n', '<Space><C-n>', ':<C-u>tabmove +1<CR>', silent)
bind('n', '<Space><C-p>', ':<C-u>tabmove -1<CR>', silent)

-- split window
bind('n', '<Space>s', ':<C-u>rightbelow split<CR>', silent)
bind('n', '<Space>v', ':<C-u>rightbelow vsplit<CR>', silent)

-- help
bind('n', '<Space>;', ':<C-u>help<Space>')

-- change encodings and formats
bind('n', '<Space>e', '<Nop>')
bind('n', '<Space>ec', ':<C-u>setlocal fileencoding=cp932<CR>', silent)
bind('n', '<Space>ee', ':<C-u>setlocal fileencoding=euc-jp<CR>', silent)
bind('n', '<Space>eu', ':<C-u>setlocal fileencoding=utf-8<CR>', silent)
bind('n', '<Space>ei', ':<C-u>setlocal fileencoding=iso-2022-jp<CR>', silent)
bind('n', '<Space>ed', ':<C-u>setlocal fileformat=dos<CR>', silent)
bind('n', '<Space>ex', ':<C-u>setlocal fileformat=unix<CR>', silent)

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
