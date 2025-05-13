local bind = vim.keymap.set

return {
  {
    'mason-org/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  { 'mason-org/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup()
    end
  },
  {
    'neovim/nvim-lspconfig',
    init = function()
      bind('n', '<Leader>dd', 'vim.lsp.buf.definition')
    end,
    config = function()
      vim.lsp.handlers['texDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
      )
    end
  },
}
