local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

return {
  {
    'thinca/vim-quickrun',
    dependencies = { 'Shougo/vimproc.vim', build = 'make' },

    init = function()
      bind('n', '<Leader>x', ':<C-u>QuickRun<CR>', silent)
      bind('n', '<Leader>X', ':<C-u>QuickRun -args ')
    end,
  },
}
