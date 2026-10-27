local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

-- file icons in the explorer
require('mini.icons').setup()

local files = require('mini.files')
files.setup({
  windows = {
    preview = true,
  },
})

-- open in the directory of the current file (falls back to cwd for unnamed buffers)
bind('n', 'sa', function()
  local path = vim.api.nvim_buf_get_name(0)
  files.open(path ~= '' and path or nil)
end, silent)
-- open in the current working directory
bind('n', 'sw', function() files.open() end, silent)

-- close with <C-j> from within the explorer
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    bind('n', '<C-j>', files.close, { buffer = args.data.buf_id })
  end,
})
