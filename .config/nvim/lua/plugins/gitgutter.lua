local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

return {
  {
    'airblade/vim-gitgutter',
    init = function()
      vim.g.gitgutter_sign_added = '+'
      vim.g.gitgutter_sign_modified = '.'
      vim.g.gitgutter_sign_removed = '-'
      vim.g.gitgutter_sign_removed_first_line = '='
      vim.g.gitgutter_sign_modified_removed = '='
      vim.g.gitgutter_map_keys = 0

      vim.keymap.set('n', '<Leader>hn', '<Plug>(GitGutterNextHunk)', silent)
      vim.keymap.set('n', '<Leader>hp', '<Plug>(GitGutterPrevHunk)', silent)
      vim.keymap.set('n', '<Leader>hh', '<Plug>(GitGutterPreviewHunk)', silent)
      vim.keymap.set('n', '<Leader>hu', '<Plug>(GitGutterUndoHunk)', silent)
      vim.keymap.set('o', 'ih', '<Plug>(GitGutterTextObjectInnerPending)', silent)
      vim.keymap.set('o', 'ah', '<Plug>(GitGutterTextObjectOuterPending)', silent)
      vim.keymap.set('x', 'ih', '<Plug>(GitGutterTextObjectInnerVisual)', silent)
      vim.keymap.set('x', 'ah', '<Plug>(GitGutterTextObjectOuterVisual)', silent)
    end,
    config = function()
      vim.api.nvim_set_hl(
        0,
        'GitGutterAdd',
        { ctermfg = 69, ctermbg = 'none', fg = '#5f87ff', bg = 'none' }
      )
      vim.api.nvim_set_hl(
        0,
        'GitGutterDelete',
        { ctermfg = 202, ctermbg = 'none', fg = '#ff5f00', bg = 'none' }
      )
      vim.api.nvim_set_hl(
        0,
        'GitGutterChange',
        { ctermfg = 221, ctermbg = 'none', fg = '#ffdf5f', bg = 'none' }
      )
      vim.api.nvim_set_hl(
        0,
        'GitGutterChangeDelete',
        { ctermfg = 221, ctermbg = 'none', fg = '#ffdf5f', bg = 'none' }
      )
    end,
  },
}
