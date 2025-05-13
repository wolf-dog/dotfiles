local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

return {
  {
    'pageer/pdv',
    ft = 'php',
    dependencies = {
      { 'tobyS/vmustache' },
    },
    init = function()
      vim.g.pdv_template_dir = vim.env.HOME .. '/.local/share/nvim/lazy/pdv/templates'

      bind('n', '<Leader>p', ':<C-u>call pdv#DocumentCurrentLine()<CR>', silent)
    end,
  },
}
