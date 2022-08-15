print("hello jyf")
require("basic.settings")
require("basic.keybinds")
require("basic.plugins")

-- vim.cmd[[colorscheme tokyonight]]

require("onedark").setup{
	transparent = true,
	toggle_style_key = "<C-s>",
	code_style = {
		comments = 'none',
		keywords = 'none',
		functions = 'none',
		strings = 'none',
		variables = 'none'
	},
	diagnostics = {
		darker = false, -- darker colors for diagnostic
		undercurl = false,   -- use undercurl instead of underline for diagnostics
		background = false,    -- use background color for virtual text
	},
}
require("onedark").load(false)
