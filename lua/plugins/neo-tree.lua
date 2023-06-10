-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- ["<cr>"] = "open_drop",

return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
		{ "MunifTanjim/nui.nvim" },
	},
	keys = {
		{
			"<leader>t",
			"<cmd>NeoTreeRevealToggle<CR>",
			"n",
			{ noremap = true, silent = true, desc = "neo-tree toggle" },
		}
	},
	config = function()
		require("neo-tree").setup({
			source_selector = {
				winbar = false,
				statusline = false,
			},
			event_handlers = {},
			close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
			popup_border_style = "single",
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				indent = {
					indent_size = 1,
					padding = 0, -- extra padding on left hand side
					-- indent guides
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					-- expander config, needed for nesting files
					with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
					-- then these will never be used.
					default = "*",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "", -- this can only be used in the git_status source
						-- Status type
						untracked = "⋢",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			window = {
				position = "left",
				width = 25,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<space>"] = { "toggle_node", nowait = true },
					["<2-LeftMouse>"] = "open",
					["<esc>"] = "revert_preview",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["<cr>"] = "open_drop",
					["t"] = "open_tab_drop",
					["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["Z"] = "expand_all_nodes",
					["a"] = "add",
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
				},
			},
			nesting_rules = {},
			filesystem = {
				directory = {
					{ "indent" },
					{ "icon" },
					{ "current_filter" },
					{
						"container",
						width = "100%",
						right_padding = 1,
						--max_width = 60,
						content = {
							{ "name", zindex = 10 },
							{
								"symlink_target",
								zindex = 10,
								highlight = "NeoTreeSymbolicLinkTarget",
							},
							{ "clipboard", zindex = 10 },
							{ "diagnostics", errors_only = true, zindex = 20, align = "right" },
						},
					},
				},
				file = {
					{ "indent" },
					{ "icon" },
					{
						"container",
						width = "100%",
						right_padding = 1,
						--max_width = 60,
						content = {
							{
								"name",
								use_git_status_colors = true,
								zindex = 10,
							},
							{
								"symlink_target",
								zindex = 10,
								highlight = "NeoTreeSymbolicLinkTarget",
							},
							{ "clipboard", zindex = 10 },
							{ "bufnr", zindex = 10 },
							{ "modified", zindex = 20, align = "right" },
							{ "diagnostics", zindex = 20, align = "right" },
							{ "git_status", zindex = 20, align = "right" },
						},
					},
				},
				filtered_items = {
					visible = true, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_hidden = true, -- only works on Windows for hidden files/directories
					hide_by_name = {
						--"node_modules"
					},
					hide_by_pattern = { -- uses glob style patterns
						--"*.meta",
						--"*/src/*/tsconfig.json",
					},
					always_show = { -- remains visible even if other settings would normally hide it
						--".gitignored",
					},
					never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
						--".DS_Store",
						--"thumbs.db"
					},
				},

				follow_current_file = true, -- This will find and focus the file in the active buffer every
				-- time the current file is changed while the tree is open.
				group_empty_dirs = true, -- when true, empty folders will be grouped together
				hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
				-- in whatever position is specified in window.position
				-- "open_current",  -- netrw disabled, opening a directory opens within the
				-- window like netrw would, regardless of window.position
				-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
				use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
				-- instead of relying on nvim autocmd events.
				window = {
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						["f"] = "filter_on_submit",
						["<c-x>"] = "clear_filter",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
					},
				},
			},
			buffers = {
				follow_current_file = true, -- This will find and focus the file in the active buffer every
				-- time the current file is changed while the tree is open.
				group_empty_dirs = true, -- when true, empty folders will be grouped together
				show_unloaded = true,
				window = {
					mappings = {
						["bd"] = "buffer_delete",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
					},
				},
			},
			git_status = {
				window = {
					position = "float",
					mappings = {
						["A"] = "git_add_all",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["gg"] = "git_commit_and_push",
					},
				},
			},
		})
	end,
}
