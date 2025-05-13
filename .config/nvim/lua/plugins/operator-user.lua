local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

return {
  {
    'emonkak/vim-operator-comment',
    dependencies = { 'kana/vim-operator-user' },
    init = function ()
      vim.keymap.set('n', '<Leader>c', '<Plug>(operator-comment)', silent)
      vim.keymap.set('n', '<Leader>C', '<Plug>(operator-uncomment)', silent)
    end
  },
  {
    'rhysd/vim-operator-surround',
    dependencies = { 'kana/vim-operator-user' },
    init = function ()
      vim.keymap.set('n', '<Leader>sa', '<Plug>(operator-surround-append)', silent)
      vim.keymap.set('n', '<Leader>sd', '<Plug>(operator-surround-delete)', silent)
      vim.keymap.set('n', '<Leader>sr', '<Plug>(operator-surround-replace)', silent)
    end
  },
}
