return {
	"stevearc/dressing.nvim",
	lazy = true,
	config = function()
		require("dressing").setup({
			input = {
				enabled = true,
				default_prompt = "Input:",
				prompt_align = "left",
				insert_only = true,
				start_in_insert = true,
				anchor = "SW",
				border = "single",
				relative = "cursor",
				prefer_width = 40,
				width = nil,
				max_width = { 140, 0.9 },
				min_width = { 20, 0.2 },
				buf_options = {},
				win_options = {
					winblend = 0,
					wrap = false,
				},
				mappings = {
					n = {
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
					},
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<Up>"] = "HistoryPrev",
						["<Down>"] = "HistoryNext",
					},
				},
				override = function(conf)
					return conf
				end,
			},
			select = {
				telescope = require("telescope.themes").get_cursor(),
				get_config = function(opts)
					print(opts.kind)
					if opts.kind == "codeaction" then
						return {
							telescope = require("telescope.themes").get_cursor({}),
						}
					elseif opts.kind == "overseer_template" then
						return {
							telescope = require("telescope.themes").get_ivy({
								layout_config = {
									height = 0.4,
								},
							}),
						}
					end
				end,
			},
		})
	end,
}
