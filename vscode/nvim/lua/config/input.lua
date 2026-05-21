local option = vim.opt

-- allow backspace to delete anything
option.backspace = 'indent,eol,start'
-- increment/decrement only digit and hex
option.nrformats = 'hex'
-- allow virtualedit in visual block mode
option.virtualedit = 'block'
-- disable mouse input
option.mouse = ''

-- searching
option.ignorecase = true
option.smartcase = true
vim.cmd('nohlsearch')

-- match <>
option.matchpairs:append({ '<:>' })
-- prevent jumping to the matching paren
option.matchtime = 0
-- show the matching brace
option.showmatch = true