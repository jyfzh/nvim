---@diagnostic disable: undefined-global
-- https://github.com/wbthomason/packer.nvim
local packer = require("packer")
packer.startup(
	{
		-- 所有插件的安装都书写在 function 中
		function(use)
			-- 包管理器
			use {
				"wbthomason/packer.nvim"
			}
			-- 启动时间管理
			use {
				"tweekmonster/startuptime.vim"
			}
			-- theme
			use {
				-- 切换主题
				'chxuan/change-colorscheme',
				'navarasu/onedark.nvim',
				'folke/tokyonight.nvim',
				'luisiacc/gruvbox-baby',
				-- {'shaunsingh/oxocarbon.nvim', run = './install.sh'}, --need cargo
			}
			-- range
			use {
				'francoiscabrol/ranger.vim',
				requires = {
					'rbgrouleff/bclose.vim',
				},
			}
			-- vim-floaterm
			use {
				'voldikss/vim-floaterm',
			}
			-- lua-line
			use {{
				'nvim-lualine/lualine.nvim',
				requires = { 'kyazdani42/nvim-web-devicons', opt = true },
				config = function()
					require("conf.lualine")
				end
				},
				{'nvim-lua/lsp-status.nvim',}
			}
			-- 模糊查找
			use {
				{
					"nvim-telescope/telescope.nvim",
					requires = {
						-- Lua 开发模块
						{"nvim-lua/plenary.nvim"},
					},
					config = function()
						require("conf.telescope")
					end
				},
				{"nvim-telescope/telescope-file-browser.nvim"},
				{"nvim-telescope/telescope-packer.nvim"},
				{"nvim-telescope/telescope-project.nvim"},
				{
					"nvim-telescope/telescope-smart-history.nvim",
					requires = {"tami5/sqlite.lua"}
				},
				{
					"nvim-telescope/telescope-frecency.nvim",
					config = function()
						require"telescope".load_extension("frecency")
					end,
					requires = {"tami5/sqlite.lua"}
				},
				{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
				{"nvim-telescope/telescope-dap.nvim",requires = {"mfussenegger/nvim-dap"}},
				{"nvim-telescope/telescope-symbols.nvim"},
				{'nvim-telescope/telescope-cheat.nvim',requires = {"tami5/sqlite.lua"}},

			}
			-- treesitter
			use {
				'nvim-treesitter/nvim-treesitter',
				run = ':TSUpdate',
				requires = {
					"p00f/nvim-ts-rainbow"
				},
				config = function()
					require("conf.nvim-treesitter")
				end
			}
			-- clangd
			use {
				"p00f/clangd_extensions.nvim",
				config = function ()
					require("conf.clangd_extensions")
				end
			}
			-- 自动匹配括号
			use {
				"windwp/nvim-autopairs",
				config = function()
					require("conf.nvim-autopairs")
				end
			}
			-- 注释
			use {
				'numToStr/Comment.nvim',
				requires = {
					"JoosepAlviste/nvim-ts-context-commentstring"
				},
				config = function()
					require('conf.comment')
				end
			}
			-- LSP 基础服务
			use {
				{
					"neovim/nvim-lspconfig",
					config = function()
						require("conf.nvim-lspconfig")
					end
				},
				{
					"williamboman/mason.nvim",
					config = function()
						require("conf.mason")
					end
				},
				{
					"williamboman/mason-lspconfig.nvim"
				},
			}
			-- LSP UI 美化
			use {{
				"kkharji/lspsaga.nvim",
				config = function()
					require("conf.lspsaga")
				end
				},
				{
					-- 插入模式获得函数签名
					"ray-x/lsp_signature.nvim",
					config = function()
						require("conf.lsp_signature")
					end
				},
			}
			-- 自动代码补全
			use {
				"hrsh7th/nvim-cmp",  -- 代码补全核心插件，下面都是增强补全的体验插件
				requires = {
					{"onsails/lspkind-nvim"}, -- 为补全添加类似 vscode 的图标
					{"hrsh7th/cmp-nvim-lsp"}, -- 替换内置 omnifunc，获得更多补全
					{"hrsh7th/cmp-buffer"}, -- 缓冲区补全
					{"hrsh7th/cmp-path"}, -- 路径补全
					{"hrsh7th/cmp-cmdline"}, -- 命令补全
					{"hrsh7th/cmp-vsnip"}, -- 适用于 vsnip 的代码片段源
					{"hrsh7th/vim-vsnip"}, -- vsnip 引擎，用于获得代码片段支持
					{"f3fora/cmp-spell"}, -- 拼写建议
					{"rafamadriz/friendly-snippets"}, -- 提供多种语言的代码片段
					{"lukas-reineke/cmp-under-comparator"}, -- 让补全结果的排序更加智能
				},
				config = function()
					require("conf.nvim-cmp")
				end
			}
			-- debug
			use {{
				"mfussenegger/nvim-dap",
				config = function()
					require('conf.nvim-dap')
				end
				},
				{
					"rcarriga/nvim-dap-ui",
					config = function ()
						require('conf.nvim-dap-ui')
					end
				},
				{
					"theHamsta/nvim-dap-virtual-text",
					requires = {
						"mfussenegger/nvim-dap",
					},
					config = function ()
						require("conf.nvim-dap-virtual-text")
					end
				}
			}
		end,
		-- 使用浮动窗口
		config = {
			display = {
				open_fn = function()
					return require('packer.util').float({ border = 'single' })
				end
			}
		}
	}
)
-- vim.cmd[[colorscheme tokyonight]]
-- https://github.com/navarasu/onedark.nvim
require("onedark").setup{
	transparent = true,
	term_colors = true, -- Change terminal color as per the selected theme style
	toggle_style_key = "<C-s>",
	code_style = {
		comments = 'none',
		keywords = 'none',
		functions = 'none',
		strings = 'none',
		variables = 'none'
	},
	-- Custom Highlights --
	colors = {}, -- Override default colors
	highlights = {
		-- TSKeyword = {fg = '$green'},
		-- TSString = {mt = 'bold'},
		TSFunction = { sp = '$cyan', fmt = 'underline'},
		Pmenu = { bg = 'NONE' },
		FloatermBorder = { bg= 'NONE' }

	}, -- Override highlight groups
	diagnostics = {
		darker = false, -- darker colors for diagnostic
		undercurl = false,   -- use undercurl instead of underline for diagnostics
		background = false,    -- use background color for virtual text
	},
}
require("onedark").load()
vim.api.nvim_create_autocmd({"VimEnter"},{
	callback = function ()
		vim.fn.timer_start(200,function ()
			vim.api.nvim_command("colo onedark")
		end)
	end
	}
)
