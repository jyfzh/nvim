-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
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
		lualine_b = {},
		lualine_c = { 'branch', 'diff' },
		lualine_x = { { "require('lsp-status').status():sub(1,60)" }, 'encoding',
			{ 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' } }, 'filetype' },
		lualine_y = {},
		lualine_z = { 'progress' },
	},
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { 'buffers', mode = 2, icons_enabled = false } },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {}
	},
	extensions = { 'quickfix', 'nvim-dap-ui', 'symbols-outline', 'neo-tree' }
}
vim.api.nvim_set_hl(0, "lualine_c_buffers_active", { fg = '#8ebd6b' })
