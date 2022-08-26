-- theme刷新

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.fn.timer_start(200, function()
			vim.api.nvim_command("colo onedark")
		end)
	end
}
)

-- 退出光标复原
vim.api.nvim_create_autocmd({"VimLeave"},{command = "set guicursor=a:ver25-blinkon0"})

--行号切换
vim.api.nvim_create_autocmd({ "InsertEnter" }, { command = "lua vim.o.relativenumber = false" })
vim.api.nvim_create_autocmd({ "InsertLeave" }, { command = "lua vim.o.relativenumber = true" })
