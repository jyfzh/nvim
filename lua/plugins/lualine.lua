-- https://github.com/nvim-lualine/lualine.nvim

vim.api.nvim_set_hl(0, "lualine_c_buffers_active", { fg = "#8ebd6b" })

vim.keymap.set("n", "<A-1>", "<cmd>LualineBuffersJump! 1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-2>", "<cmd>LualineBuffersJump! 2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-3>", "<cmd>LualineBuffersJump! 3<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-4>", "<cmd>LualineBuffersJump! 4<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-5>", "<cmd>LualineBuffersJump! 5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-6>", "<cmd>LualineBuffersJump! 6<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-7>", "<cmd>LualineBuffersJump! 7<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-8>", "<cmd>LualineBuffersJump! 8<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-9>", "<cmd>LualineBuffersJump! 9<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-$>", "<cmd>LualineBuffersJump! $<CR>", { noremap = true, silent = true })

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		"nvim-lua/lsp-status.nvim",
	},
	event = "BufRead",
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
					statusline = 4000,
					tabline = 4000,
					winbar = 4000,
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
	end,
}
