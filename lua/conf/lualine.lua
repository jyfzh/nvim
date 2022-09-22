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
		lualine_b = { 'branch' },
		lualine_c = { 'diff' },
		lualine_x = { "require('lsp-status').status():sub(1,45)" },
		lualine_y = {
			'encoding',
			{
				'fileformat',
				symbols = {
					unix = 'LF', -- e712
					dos = 'CRLF', -- e70f
					mac = 'CR', -- e711
				}
			}
		},
		lualine_z = { 'filetype' },
	},
	tabline = {
		lualine_a = { 'progress' },
		lualine_b = {},
		lualine_c = {
			{
				'buffers',
				show_filename_only = true, -- Shows shortened relative path when set to false.
				hide_filename_extension = true, -- Hide filename extension when set to true.
				show_modified_status = true, -- Shows indicator when the buffer is modified.
				mode = 2
			}
		},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { 'tabs' }
	},
	extensions = { 'quickfix', 'nvim-dap-ui', 'symbols-outline', 'neo-tree' }
}
