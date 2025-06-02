return {
  {
    'elzr/vim-json',
    ft = 'json',

    init = function()
      vim.g.vim_json_syntax_conceal = 0
    end
  },
  {
    'tpope/vim-markdown',
    ft = 'markdown',

    init = function()
      vim.g.markdown_syntax_conceal = 0
    end
  },
  { 'StanAngeloff/php.vim', ft = 'php' },
  { 'jwalton512/vim-blade', ft = 'blade' },
  { 'andys8/vim-elm-syntax', ft = 'elm' },
  { 'dag/vim-fish', ft = 'fish' },
  { 'jelera/vim-javascript-syntax', ft = 'javascript' },
  { 'vim-python/python-syntax', ft = 'python' },
}
