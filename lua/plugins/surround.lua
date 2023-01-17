return {
	"ur4ltz/surround.nvim",
	event = "BufRead",
	config = function()
		require("surround").setup({ mappings_style = "surround" })
	end,
}
