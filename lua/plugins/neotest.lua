-- https://github.com/nvim-neotest/neotest
-- https://github.com/nvim-neotest/neotest-vim-test
-- https://github.com/vim-test/vim-test

return {
	"nvim-neotest/neotest",
	dependencies = {
		"vim-test/vim-test",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/neotest-plenary",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-vim-test",
	},
	event = "BufRead",
	config = function()
		vim.cmd([[
			let test#strategy = 'neovim'  
			let g:test#preserve_screen = 0
			let g:test#neovim#start_normal = 1
			let g:test#echo_command = 0
			let test#neovim#term_position = "belowright 20"
		]])
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-plenary"),
				require("neotest-vim-test")({
					ignore_filetypes = { "python", "lua" },
				}),
			},
		})
	end,
}
