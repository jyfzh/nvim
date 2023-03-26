return {
	"ggandor/leap.nvim",
	dependencies = "tpope/vim-repeat",
	keys = {
		{ "f", "<Plug>(leap-forward-to)", mode = { "o" } },
		{ "F", "<Plug>(leap-backwardeto)", mode = { "o" } },
	},
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("leap").add_default_mappings()
	end,
}
