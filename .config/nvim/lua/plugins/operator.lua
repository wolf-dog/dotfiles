local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

--- vim-operator-comment ---
bind('n', '<Leader>c', '<Plug>(operator-comment)', silent)
bind('n', '<Leader>C', '<Plug>(operator-uncomment)', silent)

--- vim-operator-surround ---
bind('n', '<Leader>sa', '<Plug>(operator-surround-append)', silent)
bind('n', '<Leader>sd', '<Plug>(operator-surround-delete)', silent)
bind('n', '<Leader>sr', '<Plug>(operator-surround-replace)', silent)
