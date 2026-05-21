local vim = vim
local Plug = vim.fn['plug#']
local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

-- Plugins
vim.call('plug#begin')

Plug 'monaqa/dial.nvim'
Plug 'junegunn/vim-easy-align'

Plug 'kana/vim-operator-user'
Plug 'emonkak/vim-operator-comment'
Plug 'rhysd/vim-operator-surround'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-underscore'
Plug 'h1mesuke/textobj-wiw'
Plug 'thinca/vim-textobj-between'

vim.call('plug#end')

-- Key Mappings
vim.g.mapleader = ","

--- dial.nvim ---
bind('n', '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end)
bind('n', '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end)
bind('n', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end)
bind('n', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end)
bind('v', '<C-a>', function() require('dial.map').manipulate('increment', 'visual') end)
bind('v', '<C-x>', function() require('dial.map').manipulate('decrement', 'visual') end)
bind('v', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gvisual') end)
bind('v', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gvisual') end)

--- vim-easy-align ---
vim.g.easy_align_ignore_groups = { 'String' }
bind('v', '<Leader>A', '<Plug>(EasyAlign)')
bind('v', '<Leader>aa', '<Plug>(EasyAlign)*=')
bind('v', '<Leader>at', '<Plug>(EasyAlign)*<Bar>')
bind('v', '<Leader>as', '<Plug>(EasyAlign)*<Space>')
---- intaractive
bind('n', '<Leader>a', '<Plug>(EasyAlign)')

--- vim-operator-comment ---
bind('n', '<Leader>c', '<Plug>(operator-comment)', silent)
bind('n', '<Leader>C', '<Plug>(operator-uncomment)', silent)

--- vim-operator-surround ---
bind('n', '<Leader>sa', '<Plug>(operator-surround-append)', silent)
bind('n', '<Leader>sd', '<Plug>(operator-surround-delete)', silent)
bind('n', '<Leader>sr', '<Plug>(operator-surround-replace)', silent)