-- neotree
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.cmd "Neotree show left"
		-- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/519
		local manager = require("neo-tree.sources.manager")
		local state = manager.get_state("filesystem")
		local winid = state.winid
		local bufnr = state.bufnr
		vim.api.nvim_win_set_option(winid, "number", false)
	end
})

-- 退出光标复原
vim.api.nvim_create_autocmd({ "VimLeave" }, { command = "set guicursor=a:ver25-blinkon0" })

--行号切换
vim.api.nvim_create_autocmd({ "InsertEnter" }, { command = "lua vim.o.relativenumber = false" })
vim.api.nvim_create_autocmd({ "InsertLeave" }, { command = "lua vim.o.relativenumber = true" })

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

-- 关闭新行注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})
