-- Load modules
-- load display and file settings only when not in VS Code
if not vim.g.vscode then
  require("config.files")
  require("config.display")
end
require("config.input")
require("config.keymaps")
require("config.plug")

-- load the keymaps for each environment
if vim.g.vscode then
  require('config.keymaps_vscode')
else
  require('config.keymaps_nvim')
end
