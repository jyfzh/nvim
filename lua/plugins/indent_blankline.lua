-- https://github.com/lukas-reineke/indent-blankline.nvim

return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufRead",
	config = function()
		require("indent_blankline").setup({
			-- for example, context is off by default, use this to turn it on
			char = "¦", -- ['|', '¦', '┆', '┊']
			use_treesitter = true,
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = false,
			buftype_exclude = {
				"terminal",
				"[No Name]",
				"prompt",
				"nofile",
				"help",
				"TelescopePrompt",
			},
			filetype_exclude = {
				"packer",
				"log",
				"markdown",
				"org",
				"lspinfo",
				"plugin",
				"text",
			},
		})
	end,
}
