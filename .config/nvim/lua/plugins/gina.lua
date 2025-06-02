local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

return {
  {
    'lambdalisue/gina.vim',

    init = function ()
      bind('n', '<Leader>gb', ':<C-u>Gina blame<CR>', silent)
      bind('n', '<Leader>gd', ':<C-u>topleft Gina diff --opener=split<CR>', silent)
      bind('n', '<Leader>gl', ':<C-u>topleft Gina log --opener=split<CR>', silent)
      bind('n', '<Leader>gs', ':<C-u>topleft Gina status --opener=split<CR>', silent)
      bind('n', '<Leader>gg', ':<C-u>Gina grep --opener=split<Space>')
      bind('n', '<Leader>G', ':<C-u>Gina<Space>')
    end,

    config = function ()
      vim.fn['gina#custom#mapping#nmap'](
        'blame',
        '<Return>',
        '<Plug>(gina-show-commit-tab)'
      )

      vim.fn['gina#custom#mapping#nmap'](
        'log',
        '<C-s>',
        '<Plug>(gina-show-split)'
      )
      vim.fn['gina#custom#mapping#nmap'](
        'log',
        '<C-v>',
        '<Plug>(gina-show-vsplit)'
      )
      vim.fn['gina#custom#mapping#nmap'](
        'log',
        '<C-t>',
        '<Plug>(gina-show-tab)'
      )

      vim.fn['gina#custom#mapping#nmap'](
        'grep',
        '<C-s>',
        '<Plug>(gina-edit-split)'
      )

      vim.fn['gina#custom#mapping#nmap'](
        'grep',
        '<C-v>',
        '<Plug>(gina-edit-vsplit)'
      )

      vim.fn['gina#custom#mapping#nmap'](
        'grep',
        '<C-t>',
        '<Plug>(gina-edit-tab)'
      )
    end
  },
}
