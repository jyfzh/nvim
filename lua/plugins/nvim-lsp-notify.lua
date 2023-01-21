return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			background_colour = "#1e222a",
			level = "info",
			timeout = 1000,
			max_width = 40,
			max_height = 10,
			stages = "fade",
			icons = {
				ERROR = " ",
				WARN = " ",
				INFO = " ",
				DEBUG = " ",
				TRACE = " ",
			},
			render = "compact",
			top_down = true,
		})
	end,
}
