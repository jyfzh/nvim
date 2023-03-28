local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
    enabled = _G.IsNotLargeFile(),
	dependencies = {
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		{
			"L3MON4D3/LuaSnip",
			config = function()
				require("luasnip").setup({
					region_check_events = "CursorHold,InsertLeave",
					delete_check_events = "TextChanged,InsertEnter",
				})

				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
			end,
		},
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			enabled = function()
				-- https://github.com/hrsh7th/nvim-cmp/issues/519#issuecomment-1091109258
				local line = vim.api.nvim_get_current_line()
				local cursor = vim.api.nvim_win_get_cursor(0)[2]

				local current = string.sub(line, cursor, cursor + 1)
				local list = { "{", "}", "[", "(", ",", " " }
				for i = 0, #list do
					if list[i] == current then
						return false
					end
				end

				-- https://github.com/nvim-telescope/telescope.nvim/issues/94
				-- disable completion in comments
				local context = require("cmp.config.context")
				-- keep command mode completion enabled when cursor is in a comment
				if
					not vim.api.nvim_get_mode().mode == "c"
					and (context.in_treesitter_capture("comment") or context.in_syntax_group("Comment"))
				then
					return false
				end
				if vim.bo.filetype == "TelescopePrompt" or vim.bo.filetype == "neo-tree-popup" then
					return false
				end
				return true
			end,
			view = {
				entries = { name = "custom", selection_order = "near_cursor" },
			},
			window = {
				documentation = cmp.config.window.bordered(),
				complete = cmp.config.window.bordered(),
				completion = {
					scrolloff = 5,
					-- border = 'rounded',
				},
			},
			completion = {
				-- https://zhuanlan.zhihu.com/p/106070272
				completeopt = "menu,menuone,noselect",
			},
			experimental = {
				ghost_text = true, -- this feature conflict with copilot.vim's preview.
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
					elseif require("luasnip").jumpable() then
						require("luasnip").jump(-1)
					elseif has_words_before() then
					else
						cmp.complete()
					end
				end, { "i", "s" }),
				["<C-n>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					elseif require("luasnip").jumpable() then
						require("luasnip").jump(1)
					end
				end, { "i", "s" }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<C-e>"] = cmp.mapping.abort(),
				["<C-q>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "path" },
				{ name = "buffer" },
			}),
			formatting = {
				format = require("lspkind").cmp_format({
					mode = "symbol_text",
					with_text = true,
					maxwidth = 50,
					before = function(entry, vim_item)
						vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
						if string.upper(entry.source.name) == "COPILOT" then
							vim_item.kind = " Copilot"
						end
						return vim_item
					end,
				}),
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					require("copilot_cmp.comparators").prioritize,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					-- cmp.config.compare.scopes,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		})
		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		-- [`wsl``:! command` make neovim no response](https://github.com/hrsh7th/cmp-cmdline/issues/24#issuecomment-1094896592)
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
		})
	end,
}
