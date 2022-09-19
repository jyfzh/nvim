-- 取消换行注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})
-- neotree
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	command = "Neotree show left"
})

-- 退出光标复原
vim.api.nvim_create_autocmd({ "VimLeave" }, {
	command = "set guicursor=a:ver25-blinkon0"
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		if not (vim.bo.filetype == "neo-tree") then
			vim.opt_local.number = true
		end
	end,
})
--行号切换
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		if not (vim.bo.filetype == "neo-tree" or vim.bo.filetype == "floaterm") then
			vim.opt_local.relativenumber = false
			vim.cmd [[ set nu]]
		end
	end
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		if not (vim.bo.filetype == "neo-tree" or vim.bo.filetype == "floaterm") then
			vim.opt_local.relativenumber = true
		end
	end
})

-- 自动保存编辑的缓冲区
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
	pattern = { "*" },
	command = "silent! wall",
	nested = true,
})

-- 重新打开缓冲区恢复光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.fn.setpos(".", vim.fn.getpos("'\""))
			vim.cmd("silent! foldopen")
		end
	end,
})
