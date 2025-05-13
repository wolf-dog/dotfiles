local option = vim.opt

-- set encodings
option.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'
vim.cmd('language messages C')
-- detect encodings
option.fileencodings = 'ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1'

-- always use LF for eol by default
option.fileformat = 'unix'
-- detect eol formats
option.fileformats = 'unix,dos,mac'

-- no auto reload
option.autoread = false
-- no hidden buffers
option.hidden = false

-- set formatoptions
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions = 'qrMj'
  end,
})
