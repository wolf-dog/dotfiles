local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

return {
  {
    'Yggdroot/indentLine',
    init = function()
      vim.g.indentLine_color_term = 60
      vim.g.indentLine_color_gui = '#5f5f87'

      bind('n', '<Leader>t', ':<C-u>IndentLinesToggle<CR>', silent)
    end,
  },
}
