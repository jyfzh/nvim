-- 取消换行注释
-- 用o换行不要延续注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		-- vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
		vim.opt.formatoptions = vim.opt.formatoptions
			- "o" -- O and o, don't continue comments
			+ "r" -- But do continue when pressing enter.
	end,
})

-- number
local ft = { "c", "cpp", "java", "python", "lua", "vim", "html", "css", "javascript" }

local function include()
	for _, value in pairs(ft) do
		if vim.bo.filetype == value then
			return true
		end
	end
	return false
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		if include() then
			vim.opt_local.relativenumber = true
		end
	end,
})
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		if include() then
			vim.opt_local.relativenumber = false
		end
	end,
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		if include() then
			vim.opt_local.relativenumber = true
		end
	end,
})

-- 重新打开缓冲区恢复光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.fn.setpos(".", vim.fn.getpos("'\""))
			vim.cmd([[silent! foldopen]])
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	pattern = "*",
})

-- https://github.com/nvim-telescope/telescope.nvim/issues/559#issuecomment-1074076011
vim.api.nvim_create_autocmd("BufRead", {
	callback = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			command = "normal! zx",
		})
	end,
})
