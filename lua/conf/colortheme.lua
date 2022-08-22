-- vim.cmd[[colorscheme tokyonight]]
-- https://github.com/navarasu/onedark.nvim
require("onedark").setup{
	transparent = true,
	term_colors = true, -- Change terminal color as per the selected theme style
	toggle_style_key = "<C-s>",
	code_style = {
		comments = 'none',
		keywords = 'none',
		functions = 'none',
		strings = 'none',
		variables = 'none'
	},
	-- Custom Highlights --
	colors = {}, -- Override default colors
	highlights = {
		-- TSKeyword = {fg = '$green'},
		-- TSString = {fmt = 'bold'},
		TSFunction = { sp = '$cyan', fmt = 'bold'},
		Pmenu = { bg = 'NONE' },
		FloatermBorder = { bg= 'NONE' },
		rainbowcol1 = { fg='#22222' },
	}, -- Override highlight groups
	diagnostics = {
		darker = false, -- darker colors for diagnostic
		undercurl = false,   -- use undercurl instead of underline for diagnostics
		background = false,    -- use background color for virtual text
	},
}
require("onedark").load()
