-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/hrsh7th/vim-vsnip
-- https://github.com/hrsh7th/cmp-vsnip
-- https://github.com/hrsh7th/cmp-nvim-lsp
-- https://github.com/hrsh7th/cmp-path
-- https://github.com/hrsh7th/cmp-buffer
-- https://github.com/hrsh7th/cmp-cmdline
-- https://github.com/f3fora/cmp-spell
-- https://github.com/rafamadriz/friendly-snippets
-- https://github.com/lukas-reineke/cmp-under-comparator
-- https://github.com/tzachar/cmp-tabnine
-- FIX: tabline 在某些计算机上有 1 个 BUG
-- 当出现：
--    TabNine is not executable
-- 等字样时，需要手动执行（仅限 Manjaro）：
--    rm ~/.local/share/nvim/plugged/cmp-tabnine/binaries
--    ~/.local/share/nvim/plugged/cmp-tabnine/install.sh
local lspkind = require("lspkind")
local cmp = require("cmp")
cmp.setup(
---@diagnostic disable-next-line: redundant-parameter
{
	-- 指定补全引擎
	snippet = {
		expand = function(args)
			-- 使用 vsnip 引擎
			vim.fn["vsnip#anonymous"](args.body)
		end
	},
	-- 指定补全源（安装了补全源插件就在这里指定）
	sources = cmp.config.sources(
	{
		{name = "vsnip"},
		{name = "nvim_lsp"},
		{name = "path"},
		{name = "buffer"},
		{name = "cmdline"},
		{name = "spell"},
	}
	),
	window = {
		complete = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	-- 格式化补全菜单
	formatting = {
		format = lspkind.cmp_format(
		{
			with_text = true,
			maxwidth = 50,
			before = function(entry, vim_item)
				vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
				return vim_item
			end
		}
		)
	},
	-- 对补全建议排序
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			require("cmp-under-comparator").under,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order
		}
	},
	-- 绑定补全相关的按键
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		-- 下一个
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),

		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		-- 选择补全
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
}
)
