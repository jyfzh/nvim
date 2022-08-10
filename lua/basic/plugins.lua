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
				-- {'shaunsingh/oxocarbon.nvim', run = './install.sh'}, --need cargo
				'luisiacc/gruvbox-baby',
			}

			-- 中文文档
			use {
				"yianwillis/vimcdoc",
			}
			-- lua-line
			use {
				'nvim-lualine/lualine.nvim',
				requires = { 'kyazdani42/nvim-web-devicons', opt = true },
				config = function()
					require("conf.lualine")
				end
			}
			-- bufferline 
			-- use {
			-- 	'akinsho/bufferline.nvim',
			-- 	requires = 'kyazdani42/nvim-web-devicons',
			-- 	config = function()
			-- 		require("conf.bufferline")
			-- 	end
			-- }
			-- treesitter
			use {
				'nvim-treesitter/nvim-treesitter',
				run = ':TSUpdate',
				requires = {
					-- 彩虹括号
					"p00f/nvim-ts-rainbow"
				},
				config = function()
					require("conf.nvim-treesitter")
				end
			}
			-- LSP 基础服务
			-- lsp状态显示
			use {
				'j-hui/fidget.nvim',
				config = function()
					require("conf.fidget")
				end
			}
			-- lsp配置
			use {
				"neovim/nvim-lspconfig",
				config = function()
					require("conf.nvim-lspconfig")
				end
			}
			-- 自动安装 LSP
			use {
				"williamboman/mason.nvim",
				config = function()
					require("conf.mason")
				end
			}
			-- LSP UI 美化
			use {
				"tami5/lspsaga.nvim",
				config = function()
					require("conf.lspsaga")
				end
			}
			-- 自动代码补全系列插件
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
			-- 自动匹配括号
			use {
				"windwp/nvim-autopairs",
				config = function()
					require("conf.nvim-autopairs")
				end
			}
			-- 插入模式获得函数签名
			use {
				"ray-x/lsp_signature.nvim",
				config = function()
					require("conf.lsp_signature")
				end
			}
			-- 模糊查找
			use {
				"nvim-telescope/telescope.nvim",
				requires = {
					"nvim-lua/plenary.nvim", -- Lua 开发模块
				},
				config = function()
					require("conf.telescope")
				end
			}
			use "nvim-telescope/telescope-file-browser.nvim"
			use "nvim-telescope/telescope-packer.nvim"
			use "nvim-telescope/telescope-project.nvim"

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
			-- debug
			use {
				{
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
			}}
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
