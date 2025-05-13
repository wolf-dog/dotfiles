local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

local configure = function()
  vim.g.fzf_command_prefix = 'Fzf'
  vim.g.fzf_layout = { up = '~40%' }

  vim.keymap.set('n', 'ss', ':<C-u>FzfFiles<CR>', silent)
  vim.keymap.set('n', 'sg', ':<C-u>FzfGitFiles<CR>', silent)
  vim.keymap.set('n', 'sb', ':<C-u>FzfBuffers<CR>', silent)
  vim.keymap.set('n', 'sh', ':<C-u>FzfHistory<CR>', silent)
end

if ( vim.fn.empty(vim.fn.glob('~/.fzf')) == 0 ) then
  return {
    { dir = '~/.fzf' },
    {
      'junegunn/fzf.vim',
      init = function()
        configure()
      end,
    },
  }
elseif ( vim.fn.empty(vim.fn.glob('/usr/local/opt/fzf')) == 0 ) then
  return {
    { dir = '/usr/local/opt/fzf' },
    {
      'junegunn/fzf.vim',
      init = function()
        configure()
      end,
    },
  }
elseif ( vim.fn.empty(vim.fn.glob('/opt/homebrew/opt/fzf')) == 0 ) then
  return {
    { dir = '/opt/homebrew/opt/fzf' },
    {
      'junegunn/fzf.vim',
      init = function()
        configure()
      end,
    },
  }
else
  return {}
end
