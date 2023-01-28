-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/p00f/nvim-ts-rainbow
-- https://github.com/windwp/nvim-ts-autotag
-- https://github.com/Badhi/nvim-treesitter-cpp-tools
-- https://github.com/nvim-treesitter/nvim-treesitter-context
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VimEnter",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"p00f/nvim-ts-rainbow",
		"windwp/nvim-ts-autotag",
		"yioneko/nvim-yati",
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/playground",
	},
	config = function()
		-- proxy
		-- for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
		-- 	config.install_info.url =
		-- 		config.install_info.url:gsub("https://github.com/", "https://ghproxy.com/https://github.com/")
		-- end

		-- https://github.com/p00f/nvim-ts-rainbow/issues/81#issuecomment-1058124957
		local rainbow = { "#CC8888", "#CCCC88", "#88CC88", "#88CCCC", "#8888CC", "#CC88CC" }
		for i, c in ipairs(rainbow) do -- p00f/rainbow#81
			vim.cmd(("hi rainbowcol%d guifg=%s"):format(i, c))
		end

		require("nvim-treesitter.configs").setup({
			-- HACK:
			parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter",
			ensure_installed = {
				"c",
				"cpp",
				"lua",
				"python",
				"java",
				"html",
				"javascript",
				"org",
                "vim",
			},
			sync_install = true,
			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = { "org" },
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = nil,
				},
			},
			indent = {
				enable = false,
				disable = {},
			},
			yati = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
				colors = rainbow, -- table of hex strings
				termcolors = rainbow, --table of colour name strings
			},
			context_commentstring = {
				enable = true,
			},
			nt_cpp_tools = {
				enable = true,
				preview = {
					quit = "q", -- optional keymapping for quit preview
					accept = "<tab>", -- optional keymapping for accept preview
				},
				header_extension = "h", -- optional
				source_extension = "cxx", -- optional
				custom_define_class_function_commands = { -- optional
					TSCppImplWrite = {
						output_handle = require("nvim-treesitter.nt-cpp-tools.output_handlers").get_add_to_cpp(),
					},
					--[[
            <your impl function custom command name> = {
                output_handle = function (str, context) 
                    -- string contains the class implementation
                    -- do whatever you want to do with it
                end
            }
            ]]
				},
			},
			playground = {
				enable = true,
				disable = {},
				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			},
		})

		require("treesitter-context").setup({
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
				-- For all filetypes
				-- Note that setting an entry here replaces all other patterns for this entry.
				-- By setting the 'default' entry below, you can control which nodes you want to
				-- appear in the context window.
				default = {
					"class",
					"function",
					"method",
					"for",
					"while",
					"if",
					"switch",
					"case",
				},
				-- Patterns for specific filetypes
				-- If a pattern is missing, *open a PR* so everyone can benefit.
				tex = {
					"chapter",
					"section",
					"subsection",
					"subsubsection",
				},
				rust = {
					"impl_item",
					"struct",
					"enum",
				},
				scala = {
					"object_definition",
				},
				vhdl = {
					"process_statement",
					"architecture_body",
					"entity_declaration",
				},
				markdown = {
					"section",
				},
				elixir = {
					"anonymous_function",
					"arguments",
					"block",
					"do_block",
					"list",
					"map",
					"tuple",
					"quoted_content",
				},
				json = {
					"pair",
				},
				yaml = {
					"block_mapping_pair",
				},
			},
			exact_patterns = {
				-- Example for a specific filetype with Lua patterns
				-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
				-- exactly match "impl_item" only)
				-- rust = true,
			},

			-- [!] The options below are exposed but shouldn't require your attention,
			--     you can safely ignore them.

			zindex = 20, -- The Z-index of the context window
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
		})
	end,
}
