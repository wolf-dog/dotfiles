local vim = vim
local Plug = vim.fn['plug#']

-- set the leader before declaring plugins so that <Leader> mappings are correct
vim.g.mapleader = ","

-- Plugins
vim.call('plug#begin')

Plug 'monaqa/dial.nvim'
Plug 'junegunn/vim-easy-align'

Plug 'kana/vim-operator-user'
Plug 'emonkak/vim-operator-comment'
Plug 'rhysd/vim-operator-surround'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-underscore'
Plug 'h1mesuke/textobj-wiw'
Plug 'thinca/vim-textobj-between'

-- plugins loaded only when not in VS Code
if not vim.g.vscode then
  Plug 'wolf-dog/sceaduhelm.vim'
  Plug 'wolf-dog/lightline-sceaduhelm.vim'
  Plug 'itchyny/lightline.vim'

  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'brenoprata10/nvim-highlight-colors'

  Plug 'echasnovski/mini.files'
  Plug('junegunn/fzf', { ['do'] = './install --bin' })
  Plug 'ibhagwan/fzf-lua'

  Plug 'vim-scripts/sudo.vim'
  Plug 'guns/xterm-color-table.vim'

  -- syntax ('for' is a Lua keyword, hence the bracket syntax)
  Plug('elzr/vim-json', { ['for'] = 'json' })
  Plug('tpope/vim-markdown', { ['for'] = 'markdown' })
  Plug('StanAngeloff/php.vim', { ['for'] = 'php' })
  Plug('jwalton512/vim-blade', { ['for'] = 'blade' })
  Plug('andys8/vim-elm-syntax', { ['for'] = 'elm' })
  Plug('dag/vim-fish', { ['for'] = 'fish' })
  Plug('jelera/vim-javascript-syntax', { ['for'] = 'javascript' })
  Plug('vim-python/python-syntax', { ['for'] = 'python' })
end

vim.call('plug#end')

-- Plugin settings
require('plugins.dial')
require('plugins.easy-align')
require('plugins.operator')

-- settings loaded only when not in VS Code
if not vim.g.vscode then
  require('plugins.colorscheme')
  require('plugins.lightline')
  require('plugins.indent-blankline')
  require('plugins.nvim-highlight-colors')
  require('plugins.mini-files')
  require('plugins.fzf-lua')
  require('plugins.syntax')
end
