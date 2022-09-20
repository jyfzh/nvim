-- 取消换行注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})
-- neotree
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	command = "NeoTreeShow"
})

-- 退出光标复原
vim.api.nvim_create_autocmd({ "VimLeave" }, {
	command = "set guicursor=a:ver25-blinkon0"
})

local ft = {
	"neo-tree",
	"neo-tree-pop",
	"floaterm",
	"plugin"
}

--行号切换
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		for _, value in pairs(ft) do
			if not (vim.bo.filetype == value) then
				vim.opt_local.relativenumber = true
			end
		end
	end
})
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		for _, value in pairs(ft) do
			if not (vim.bo.filetype == value) then
				vim.opt_local.relativenumber = false
			end
		end
	end
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		for _, value in pairs(ft) do
			if not (vim.bo.filetype == value) then
				vim.opt_local.relativenumber = true
			end
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
