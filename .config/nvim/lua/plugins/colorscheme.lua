vim.opt.background = 'dark'
vim.g.sceaduhelm_transparent_bg = 1

-- fall back to a bundled colorscheme until :PlugInstall has fetched sceaduhelm,
-- otherwise the error aborts the rest of init.lua on the first launch
if not pcall(vim.cmd.colorscheme, 'sceaduhelm') then
  vim.cmd.colorscheme('habamax')
end
