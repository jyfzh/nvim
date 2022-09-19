-- https://github.com/navarasu/onedark.nvim
require("onedark").setup {
	transparent = true,
	term_colors = false, -- Change terminal color as per the selected theme style
	toggle_style_key = "<C-s>",
	style = 'darker',
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
		-- TSFunction     = { sp = '$cyan', fmt = 'bold' },
		Normal                 = { bg = 'NONE' },
		NormalFloat            = { sp = 'NONE', guibg = 'NONE' },
		Floaterm               = { bg = 'NONE' },
		FloatermBorder         = { bg = 'NONE' },
		TelescopePromptBorder  = { fg = '#a7b8d6' },
		TelescopePreviewBorder = { fg = '#a7b8d6' },
		TelescopeResultsBorder = { fg = '#a7b8d6' },
	}, -- Override highlight groups
	diagnostics = {
		darker = false, -- darker colors for diagnostic
		undercurl = false, -- use undercurl instead of underline for diagnostics
		background = false, -- use background color for virtual text
	},
}
require "onedark".load()
