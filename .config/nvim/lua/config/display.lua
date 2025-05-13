local option = vim.opt

option.list = true
option.listchars = 'tab:|-,trail:<'
option.number = true
-- display doublewidth char correctly
option.ambiwidth = 'double'
-- always show the last line of the file, not @
option.display = 'lastline'
-- open all folds when starting to edit another buffer
option.foldlevelstart = 99
-- use markers for folding
option.foldmethod = 'syntax'
-- let the cursor keep 3 lines away from edge of the window
option.scrolloff = 3
-- disable intro message
option.shortmess:append({ I = true })
-- set title of the window
option.title = true

-- status line, tab line
-- show fileencoding (or internal encoding) in the status line
vim.o.statusline = '%<%f %h%m%r%w%=[%{&l:fileencoding == "" ? &encoding : &l:fileencoding}] %-14.(%l,%c%V%) %P'
-- always show the tabline
option.showtabline = 2

-- tabs and indents
option.cindent = true
option.expandtab = true
option.shiftround = true
option.shiftwidth = 2
option.smarttab = true
option.softtabstop = 2
option.tabstop = 2

-- show ideographic spaces
vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'IdeographicSpace', { ctermbg = 'Red', bg = 'Red' })
  end
})
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter' }, {
  pattern = '*',
  callback = function()
    vim.w.match_additional = vim.fn.matchadd('IdeographicSpace', '\\%u3000')
  end
})
