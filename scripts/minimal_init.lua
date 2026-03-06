vim.opt.runtimepath:append('.')

local cwd = vim.fn.getcwd()
vim.cmd(string.format([[set packpath=%s/.ci/vendor]], cwd))
vim.cmd([[packloadall]])

vim.o.swapfile = false
vim.bo.swapfile = false

