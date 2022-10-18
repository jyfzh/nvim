-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-project.nvim
-- https://github.com/GustavoKatel/telescope-asynctasks.nvim

-- [telescope-z empty](https://github.com/nvim-telescope/telescope-z.nvim/issues/14#issuecomment-1221745266)
vim.g.sqlite_clib_path = "C:/Windows/System32/sqlite3.dll"
require('telescope').setup {
	defaults = {
		history = {
			path = vim.fn.stdpath "data" .. '/telescope_history.sqlite3',
			limit = 100,
		},
		vimgrep_arguments = {
			"rg", "--color=never", "--no-heading", "--with-filename",
			"--line-number", "--column", "--smart-case", "--trim",
			'--no-ignore', '--hidden'
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		sorting_strategy = "descending",
		file_ignore_patterns = { "^node_modules/", "^.git/" },
		path_display = { "smart" },
		winblend = 0,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		mappings = {},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			previewer = false
		},
		diagnostics = {
			theme = "ivy",
			previewer = false,
			layout_config = {
				height = 0.3
			}
		},
	},
	extensions = {
		packer = {
			theme = "ivy",
			previewer = false,
			border = true,
			layout_config = {
				height = .9
			}
		},
		project = {
			theme = "dropdown",
			hidden_files = true, -- default: false
			-- order_by = "asc",
			base_dirs = {
				-- '/home/jyf/.config/nvim',
				-- {'~/dev/src3', max_depth = 4},
				-- {path = '~/dev/src5'},
				-- {path = '~/dev/src5', max_depth = 2},
			},
			mappings = {
			},
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case",the default case_mode is "smart_case"
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown {}
		},
	},
}
-- you need to call load_extension, somewhere after setup function:
require('telescope').load_extension 'packer'
require('telescope').load_extension 'project'
require('telescope').load_extension 'fzf'
require('telescope').load_extension 'smart_history'
require('telescope').load_extension 'dap'
require('telescope').load_extension 'ui-select'
require('telescope').load_extension 'z'
require('telescope').load_extension 'asynctasks'
require('telescope').load_extension 'floaterm'
