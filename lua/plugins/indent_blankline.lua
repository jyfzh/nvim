return {
	"lukas-reineke/indent-blankline.nvim",
    -- do not lazy load due to https://github.com/lukas-reineke/indent-blankline.nvim/issues/542
	config = function()
		require("indent_blankline").setup({
			char = "",
            context_char = "¦", -- ['|', '¦', '┆', '┊']
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
				"lspinfo",
				"plugin",
				"text",
                "lazy"
			},
		})
	end,
}
