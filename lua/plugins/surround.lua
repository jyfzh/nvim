return {
	"ur4ltz/surround.nvim",
	dependencies = "tpope/vim-repeat",
	event = "BufRead",
	config = function()
		require("surround").setup({ mappings_style = "surround" })
	end,
}
