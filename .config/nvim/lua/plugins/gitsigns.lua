local bind = vim.keymap.set
local silent = { silent = true, noremap = true }
return {

  {
    'lewis6991/gitsigns.nvim',

    dependencies = {

      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require('statuscol.builtin')
          require('statuscol').setup({
            relculright = true,
            segments = {
              {
                sign = {
                  namespace = { 'gitsigns' },

                  maxwidth = 1,
                  auto = true
                },

              },
              {
                sign = {
                  namespace = { 'nvim.vim.lsp.*.diagnostic.signs' },
                  maxwidth = 1,
                  auto = true
                },
              },
              {
                text = { builtin.lnumfunc },
              },
              { text = { '│' } },
            },
          })
        end,
      },
    },
    config = function()
      require('gitsigns').setup({
        signcolumn = true,
        numhl = true,
        signs = {
          add          = { text = '┆' },
          change       = { text = '┆' },
          delete       = { text = '┆' },
          topdelete    = { text = '┆' },
          changedelete = { text = '┆' },

          untracked    = { text = '┆' },
        },
        signs_staged = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '│' },
          topdelete    = { text = '│' },
          changedelete = { text = '│' },
          untracked    = { text = '│' },
        },
        on_attach = function(bufnr)
        end,
      })
      vim.api.nvim_set_hl(0, 'GitSignsAdd', { ctermfg = 153, fg = '#afdfff' })
      vim.api.nvim_set_hl(0, 'GitSignsChange', { ctermfg = 221, fg = '#ffdf5f' })
      vim.api.nvim_set_hl(0, 'GitSignsDelete', { ctermfg = 166, fg = '#df5f00' })
    end,
  },
}
