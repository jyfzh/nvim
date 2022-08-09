-- https://github.com/nvim-telescope/telescope.nvim
-- WARN: telescope 手动安装依赖 fd 和 repgrep
-- https://github.com/sharkdp/fd
-- https://github.com/BurntSushi/ripgrep
require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim"
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		sorting_strategy = "descending",
		file_ignore_patterns = { "node_modules" },
		path_display = { "smart" },
		winblend = 18,
		border = false,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "bottom",
				preview_width = 0.6,
				results_width = 0.5,
			},
			vertical = {
				mirror = false,
			},
			width = 0.9,
			height = 0.9,
			preview_cutoff = 60,
		},
	},
	pickers = {
		find_files = {
			-- theme = "dropdown",
		},
		live_grep = {
			-- theme = "dropdown",
		},
		diagnostics = {
			theme = "dropdown",
		},
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			path_display = { "tail" },
			preview_cutoff = 60,
			layout_config = {
				height = .9
			},
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
		packer = {
			theme = "ivy",
			layout_config = {
				height = .9
			}
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown {
				-- even more opts
			}

			-- pseudo code / specification for writing custom displays, like the one
			-- for "codeactions"
			-- specific_opts = {
			--   [kind] = {
			--     make_indexed = function(items) -> indexed_items, width,
			--     make_displayer = function(widths) -> displayer
			--     make_display = function(displayer) -> function(e)
			--     make_ordinal = function(e) -> string
			--   },
			--   -- for example to disable the custom builtin "codeactions" display
			--      do the following
			--   codeactions = false,
			-- }
		},
		project = {
			theme = "cursor",
			base_dirs = {
				'~/cpp',
				'~/java',
				-- '/home/jyf/.config/nvim',
				-- {'~/dev/src3', max_depth = 4},
				-- {path = '~/dev/src5'},
				-- {path = '~/dev/src5', max_depth = 2},
			},
			hidden_files = false, -- default: false
		},
	},
}

-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension 'file_browser'
require("telescope").load_extension "packer"
require'telescope'.load_extension('project')
