-- Load modules
-- VS Code環境「ではない」ときだけ、画面表示やファイル設定を読み込む
if not vim.g.vscode then
  require("config.files")
  require("config.display")
end
require("config.input")
require("config.keymaps")
require("config.plug")

-- 環境ごとの専用キーマップを読み込む
if vim.g.vscode then
  require('config.keymaps_vscode')
else
  require('config.keymaps_nvim')
end
