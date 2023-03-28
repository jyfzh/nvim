function IsNotLargeFile()
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
	if ok and stats and stats.size > max_filesize then
		vim.wo.foldexpr = "0"
		return false
	else
		vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
		return true
	end
end
