local bind = vim.keymap.set

vim.g.easy_align_ignore_groups = { 'String' }

bind('v', '<Leader>A', '<Plug>(EasyAlign)')
bind('v', '<Leader>aa', '<Plug>(EasyAlign)*=')
bind('v', '<Leader>at', '<Plug>(EasyAlign)*<Bar>')
bind('v', '<Leader>as', '<Plug>(EasyAlign)*<Space>')
-- intaractive
bind('n', '<Leader>a', '<Plug>(EasyAlign)')
