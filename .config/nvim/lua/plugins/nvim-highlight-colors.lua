-- skip until :PlugInstall has fetched it, otherwise the error aborts init.lua
local ok, highlight_colors = pcall(require, 'nvim-highlight-colors')
if ok then
  highlight_colors.setup({})
end
