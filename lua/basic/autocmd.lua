vim.api.nvim_create_autocmd({"VimEnter"},{
	callback = function ()
		vim.fn.timer_start(200,function ()
			vim.api.nvim_command("colo onedark")
		end)
	end
	}
)
vim.api.nvim_create_autocmd({"InsertEnter"},{ command="lua vim.o.relativenumber = false"})
vim.api.nvim_create_autocmd({"InsertLeave"},{ command="lua vim.o.relativenumber = true"})
