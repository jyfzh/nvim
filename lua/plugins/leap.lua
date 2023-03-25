return {
	"ggandor/leap.nvim",
	dependencies = "tpope/vim-repeat",
	event = "BufRead",
	config = function()
		require("leap").add_default_mappings()
	end,
}
