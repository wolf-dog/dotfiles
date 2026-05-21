local bind = vim.keymap.set
local silent = { silent = true, noremap = true }

-- use screen lines normally with vs code
bind({ 'n', 'x' }, 'j', function()
  if vim.v.count == 0 then
    require('vscode').call('cursorMove', { args = { { to = 'down', by = 'wrappedLine', value = 1 } } })
    return '<Ignore>'
  else
    return 'j'
  end
end, { expr = true, silent = true })

bind({ 'n', 'x' }, 'k', function()
  if vim.v.count == 0 then
    require('vscode').call('cursorMove', { args = { { to = 'up', by = 'wrappedLine', value = 1 } } })
    return '<Ignore>'
  else
    return 'k'
  end
end, { expr = true, silent = true })

-- quit active editor
bind('n', 'Q', function() require('vscode').call('workbench.action.closeActiveEditor') end, silent)

-- tab navigation
bind('n', '<C-n>', function() require('vscode').call('workbench.action.nextEditor') end, silent)
bind('n', '<C-p>', function() require('vscode').call('workbench.action.previousEditor') end, silent)

-- open a new tab
bind('n', '<Space>t', function() require('vscode').call('workbench.action.files.newUntitledFile') end, silent)

-- move tab to next/previous
bind('n', '<Space><C-n>', function() require('vscode').call('workbench.action.moveEditorRightInGroup') end, silent)
bind('n', '<Space><C-p>', function() require('vscode').call('workbench.action.moveEditorLeftInGroup') end, silent)

-- split window
bind('n', '<Space>s', function() require('vscode').call('workbench.action.splitEditorDown') end, silent)
bind('n', '<Space>v', function() require('vscode').call('workbench.action.splitEditorRight') end, silent)

-- help
bind('n', '<Space>;', function() require('vscode').call('workbench.action.showCommands') end, silent)

-- LSP
bind('n', '<Space>kk', function() require('vscode').call('editor.action.revealDefinition') end)
bind('n', '<Space>ka', function() require('vscode').call('editor.action.quickFix') end)
bind('n', '<Space>kd', function() require('vscode').call('editor.action.peekDefinition') end)
bind('n', '<Space>kf', function() require('vscode').call('editor.action.formatDocument') end)
bind('n', '<Space>kh', function() require('vscode').call('editor.action.showHover') end)
bind('n', '<Space>kr', function() require('vscode').call('editor.action.goToReferences') end)

bind('n', '<Space>jj', function() require('vscode').call('editor.action.marker.nextInFiles') end)
bind('n', '<Space>jq', function() require('vscode').call('workbench.actions.view.problems') end)
bind('n', '<Space>jn', function() require('vscode').call('editor.action.marker.next') end)
bind('n', '<Space>jp', function() require('vscode').call('editor.action.marker.prev') end)

-- VSCode specific functions
bind('n', 'ss', function() require('vscode').call('workbench.action.quickOpen') end, silent)
bind('n', 'sq', function() require('vscode').call('workbench.action.toggleSidebarVisibility') end, silent)