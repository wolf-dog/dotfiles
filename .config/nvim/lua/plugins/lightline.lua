vim.g.lightline = {
  colorscheme = 'sceaduhelm',
  enable = {
    statusline = 1,
    tabline = 1,
  },
  tabline_subseparator = {
    left = '',
    right = '',
  },
  active = {
    left = {
      { 'mode', 'paste' },
      { 'readonly', 'absolutepath', 'modified' },
    },
  },
}
