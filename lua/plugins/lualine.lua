-- https://github.com/nvim-lualine/lualine.nvim

vim.api.nvim_set_hl(0, "lualine_c_buffers_active", { fg = "#8ebd6b" })

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		"nvim-lua/lsp-status.nvim",
	},
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = {} },
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {},
				lualine_c = { "branch", "diff" },
				lualine_x = {
					{ "require('lsp-status').status()" },
					"encoding",
					{ "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } },
					"filetype",
				},
				lualine_y = {},
				lualine_z = { "progress" },
			},
			tabline = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "buffers", mode = 2, icons_enabled = true } },
				lualine_x = { "tabs" },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "quickfix", "nvim-dap-ui", "symbols-outline", "neo-tree", "man", "toggleterm", "fugitive" },
		})
	end
}
