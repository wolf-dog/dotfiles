return {
  {
    'wolf-dog/sceaduhelm.vim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = 'dark'
      vim.g.sceaduhelm_transparent_bg = 1
      vim.cmd('colorscheme sceaduhelm')
    end,
  },

  { 'vim-scripts/sudo.vim' },
  { 'guns/xterm-color-table.vim' },
}
