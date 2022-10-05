vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd [[ mks! ~/.local/share/nvim/workspace.vim ]]
	end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
	command = "set guicursor=a:ver25-blinkon0"
})

--行号切换
local ft = { "c", "cpp", "java", "python", "lua", "vim", "html", "css", "javascript" }

local function include()
	for _, value in pairs(ft) do
		if (vim.bo.filetype == value) then
			return true
		end
	end
	return false
end

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

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		if include() then
			vim.opt_local.relativenumber = true
		end
	end
})
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		if include() then
			vim.opt_local.relativenumber = false
			vim.opt_local.number = true
		end
	end
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		if include() then
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

-- bulb
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- colorizer
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.html", "*.css" },
	command = "ColorizerAttachToBuffer"
})

vim.api.nvim_create_autocmd("BufLeave", {
	pattern = { "*.html", "*.css" },
	command = "ColorizerDetachFromBuffer"
})


-- 保存时自动格式化
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua", "*.py", "*.sh" },
	callback = vim.lsp.buf.formatting_sync,
})


-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	pattern = "*",
})


-- 工作区改变删除buffer
function Bufdelete()
	vim.cmd [[LspStop vim.bo.filetype ]]
	vim.cmd [[bufdo! bd!]]
end

vim.api.nvim_create_user_command("Bd", "lua Bufdelete()", {})
