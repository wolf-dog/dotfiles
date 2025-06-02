local bind = vim.keymap.set
local silent = { silent = true, noremap = true }
local silentBuf = { noremap = true, silent = true, buffer = true }
return {
  {
    'lambdalisue/vim-fern',

    dependencies = {
      'yuki-yano/fern-preview.vim',
      'lambdalisue/vim-fern-git-status',
      {
        'lambdalisue/vim-fern-renderer-nerdfont',
        dependencies = {
          'lambdalisue/vim-nerdfont',
          'lambdalisue/vim-glyph-palette',
        },
      },
    },

    init = function()
      vim.g['fern#renderer'] = 'nerdfont'
      bind('n', 'sa', [[<Cmd>Fern . <CR>]], silent)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fern',
        callback = function()
          vim.cmd('call glyph_palette#apply()')
          bind('n', 'l', [[<Plug>(fern-action-expand)]], silentBuf)
          bind('n', 'p', [[<Plug>(fern-action-preview:toggle)]], silentBuf)
        end,
      })
    end,
  },
}
