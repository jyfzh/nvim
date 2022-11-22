-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-project.nvim
-- https://github.com/GustavoKatel/telescope-asynctasks.nvim

require('telescope').setup {
	defaults = {
		border = false,
		winblend = 0,
		dynamic_preview_title = true,
		path_display = { "smart" },
		layout_strategy = 'bottom_pane',
		layout_config = {
			bottom_pane = {
				height = 0.5,
				preview_cutoff = 120,
				prompt_position = "bottom"
			},
			center = {
				height = 0.4,
				preview_cutoff = 40,
				prompt_position = "top",
				width = 0.9
			},
			cursor = {
				height = 0.9,
				preview_cutoff = 40,
				width = 0.8
			},
			vertical = {
				width = 0.9,
				height = 0.9,
			},
			horizontal = {
				width = 0.9,
				height = 0.9,
			},
		},
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
		file_ignore_patterns = {
			"^node_modules", "^.git", "build", ".cache", "%.class"
		},
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		mappings = {
			i = {
				["<C-f>"] = require("telescope.actions").preview_scrolling_down,
				["<C-b>"] = require("telescope.actions").preview_scrolling_up,
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<C-q>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist,
				["<esc>"] = require("telescope.actions").close,
			},
		},
	},
	pickers = {
		find_files = {
			layout_strategy = "horizontal",
			prompt_title = "   Find File",
			layout_config = {
				height = 0.95,
				width = 0.95,
				preview_cutoff = 80
			},
		},
		keymaps = {
			prompt_title = "   Keymaps",
			theme = "dropdown",
		},
		current_buffer_fuzzy_find = {
			prompt_title = " ﬘  Current Buffer",
			theme = "ivy",
		},
		live_grep = {
			prompt_title = "   Live Grep",
			theme = "ivy",
			previewer = false,
		},
		help_tags = {
			prompt_title = "  Help Tags",
			theme = "ivy",
			layout_config = {
				preview_cutoff = 0
			},
		},
		oldfiles = {
			prompt_title = "   Old Files",
			theme = "ivy",
		},
		marks = {
			prompt_title = "  Marks",
			theme = "ivy",
		},
		buffers = {
			prompt_title = " ﬘ Buffers",
			theme = "ivy",
			layout_config = {
				preview_cutoff = 0;
			}
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
		project = {
			theme = "dropdown",
			hidden_files = true,
			-- order_by = "asc",
			base_dirs = {},
			mappings = {},
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
require('telescope').load_extension 'project'
require('telescope').load_extension 'fzf'
require('telescope').load_extension 'smart_history'
require('telescope').load_extension 'dap'
require('telescope').load_extension 'ui-select'
require('telescope').load_extension 'asynctasks'
