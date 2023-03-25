return {
	"ojroques/nvim-bufdel",
    lazy = true,
	keys = {
		{ "<leader>bdc", "<cmd>BufDel<CR>", "n", { noremap = true } },
		{ "<leader>bda", "<cmd>BufDelAll<CR>", "n", { noremap = true } },
		{ "<leader>bdo", "<cmd>BufDelOthers<CR>", "n", { noremap = true } },
	},
	config = function()
		require("bufdel").setup({
			next = "alternate", -- or 'cycle, 'alternate', 'tabs'
			quit = false, -- quit Neovim when last buffer is closed
		})
	end,
}
