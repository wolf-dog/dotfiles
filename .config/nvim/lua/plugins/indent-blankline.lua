local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

local hooks = require('ibl.hooks')
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#5f5f87', ctermfg = 60 })
end)

require('ibl').setup({
  indent = { char = '|' },
})

bind('n', '<Leader>t', ':<C-u>IBLToggle<CR>', silent)
