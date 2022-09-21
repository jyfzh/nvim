-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 4000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch' },
		lualine_c = { 'diff' },
		lualine_x = { "require('lsp-status').status():sub(1,45)" },
		lualine_y = { 'encoding', 'fileformat', 'filetype' },
		lualine_z = { 'progress' },
	},
	tabline = {
		lualine_a = { 'require("hydra.statusline").get_name()' },
		lualine_b = {},
		lualine_c = { 'buffers' },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {}
	},
	extensions = { 'quickfix', 'nvim-dap-ui', 'symbols-outline', 'neo-tree' }
}
