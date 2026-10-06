local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

local fzf = require('fzf-lua')
fzf.setup({
  winopts = {
    border = 'solid',
    preview = {
      border = 'solid',
      scrollchars = { '|', '' },
    },
  },
  -- keep the fzf UI punctuation ASCII-only
  fzf_opts = {
    ['--no-unicode'] = true,
  },
  keymap = {
    fzf = {
      true, -- inherit default binds
      ['ctrl-j'] = 'abort',
      ['ctrl-k'] = 'ignore',
    },
  },
})

bind('n', 'ss', fzf.files, silent)
bind('n', 'sg', fzf.live_grep, silent)
bind('n', 'sb', fzf.buffers, silent)
bind('n', 'sr', fzf.oldfiles, silent)
