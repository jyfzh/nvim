-- https://github.com/norcalli/nvim-colorizer.lua

return {
	"norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("colorizer").setup({
			"css",
			"javascript",
			"html",
		}, {
			RGB = true, -- #RGB hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			names = true, -- "Name" codes like Blue
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			-- Available modes: foreground, background
			mode = "background", -- Set the display mode.
		})

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = { "*.html", "*.css" },
			command = "ColorizerAttachToBuffer",
		})

		vim.api.nvim_create_autocmd("BufLeave", {
			pattern = { "*.html", "*.css" },
			command = "ColorizerDetachFromBuffer",
		})
	end,
}
