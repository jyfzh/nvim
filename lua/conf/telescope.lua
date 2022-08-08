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
		-- file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		-- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "smart" },
		winblend = 18,
		border = false,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		-- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		-- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		-- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		--
		-- Developer configurations: Not meant for general override
		-- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
	},
	pickers = {
		find_files = {
			-- theme = "dropdown",
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
				preview_cutoff = 20,
			},
		},
		live_grep = {
			-- theme = "dropdown",
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
				preview_cutoff = 20,
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
	},

	extensions_list = { "themes", "terms" },
}

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"
