-- 退出光标复原
vim.api.nvim_create_autocmd({ "VimLeave" }, { command = "set guicursor=a:ver25-blinkon0" })

--行号切换
vim.api.nvim_create_autocmd({ "InsertEnter" }, { command = "lua vim.o.relativenumber = false" })
vim.api.nvim_create_autocmd({ "InsertLeave" }, { command = "lua vim.o.relativenumber = true" })

vim.api.nvim_create_autocmd({ "BufWinEnter" }, { command = "Neotree show" })
