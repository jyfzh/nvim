-- https://github.com/nvim-telescope/telescope.nvim
-- WARN: telescope 手动安装依赖 fd 和 repgrep
-- https://github.com/sharkdp/fd
-- https://github.com/BurntSushi/ripgrep
require('telescope').setup{
	defaults = {
		-- layout_strategy= "horizontal",
		layout_config = {
			width = 0.99,
			-- other layout configuration here
			preview_cutoff = 20,
		},
		-- file_previewer = require('telescope.previewers').vim_buffer_cat.new
	},
	pickers = {
		find_files = {
			-- theme = "dropdown",
		},
	},
	extensions = {
		-- ...
	}
	-- defaults = {
	-- 	vimgrep_arguments = {
	-- 		"rg",
	-- 		"--color=never",
	-- 		"--no-heading",
	-- 		"--with-filename",
	-- 		"--line-number",
	-- 		"--column",
	-- 		"--smart-case",
	-- 	},
	-- 	prompt_prefix = "   ",
	-- 	selection_caret = "  ",
	-- 	entry_prefix = "  ",
	-- 	initial_mode = "insert",
	-- 	selection_strategy = "reset",
	-- 	sorting_strategy = "ascending",
	-- 	layout_strategy = "horizontal",
	-- 	layout_config = {
	-- 		horizontal = {
	-- 			prompt_position = "top",
	-- 			preview_width = 0.55,
	-- 			results_width = 0.8,
	-- 		},
	-- 		vertical = {
	-- 			mirror = false,
	-- 		},
	-- 		width = 0.87,
	-- 		height = 0.80,
	-- 		preview_cutoff = 120,
	-- 	},
	-- 	file_sorter = require("telescope.sorters").get_fuzzy_file,
	-- 	file_ignore_patterns = { "node_modules" },
	-- 	generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
	-- 	path_display = { "truncate" },
	-- 	winblend = 0,
	-- 	border = {},
	-- 	borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
	-- 	color_devicons = true,
	-- 	set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
	-- 	file_previewer = require("telescope.previewers").vim_buffer_cat.new,
	-- 	grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
	-- 	qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	-- 	-- Developer configurations: Not meant for general override
	-- 	buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	-- 	mappings = {
	-- 		n = { ["q"] = require("telescope.actions").close },
	-- 	},
	-- },
	-- --
	-- extensions_list = { "themes", "terms" },
}
