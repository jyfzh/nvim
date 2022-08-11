print("hello jyf")
require("basic.settings")
require("basic.keybinds")
require("basic.plugins")

-- vim.cmd[[colorscheme tokyonight]]

require("onedark").setup{
	transparent = true,
	toggle_style_key = "<C-s>"
}
require("onedark").load(false)
