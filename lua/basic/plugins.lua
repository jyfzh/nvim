-- https://github.com/wbthomason/packer.nvim

-- @diagnostic disable: undefined-global
local ensure_packer = function()
	local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.notify("Installing Pakcer.nvim ... ")
		vim.fn.system({
			'git', 'clone', '--depth', '1',
			'https://github.com/wbthomason/packer.nvim',
			install_path
		})
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local packer = require("packer")
packer.startup(
	{
		function(use)
			use {
				"wbthomason/packer.nvim"
			}
			-- theme
			use {
				'folke/tokyonight.nvim',
				'luisiacc/gruvbox-baby',
				'navarasu/onedark.nvim'
			}
			-- vim-floaterm
			use { 'voldikss/vim-floaterm' }
			-- notify
			use { 'rcarriga/nvim-notify' }
			--  draw
			use {
				"jbyuki/venn.nvim",
				keys = "<leader>v",
				config = function() require("conf.venn") end
			}
			-- git
			use {
				'lewis6991/gitsigns.nvim',
				config = function() require("conf.gitsigns") end
			}
			use {
				'karb94/neoscroll.nvim',
				config = function () require("conf.neoscroll") end
			}
			-- neo-tree
			use {
				"nvim-neo-tree/neo-tree.nvim",
				requires = {
					{ "nvim-lua/plenary.nvim" },
					{ "kyazdani42/nvim-web-devicons" }, -- not strictly required, but recommended
					{ "MunifTanjim/nui.nvim" },
				},
				config = function() require("conf.neo-tree") end
			}
			-- async
			use {
				'skywind3000/asynctasks.vim',
				requires = {
					{
						'skywind3000/asyncrun.vim',
						config = function() vim.cmd [[  let g:asyncrun_open = 6 ]] end
					}
				},
			}
			-- sniprun
			use {
				'michaelb/sniprun',
				run = './install.sh',
				config = function() require("conf.sniprun") end
			}
			-- markdown-preview https://github.com/iamcco/markdown-preview.nvim
			use { "iamcco/markdown-preview.nvim",
				run = "cd app && npm install",
				setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
				ft = { "markdown" },
			}
			-- test
			use {
				"nvim-neotest/neotest",
				requires = {
					"vim-test/vim-test",
					'nvim-lua/plenary.nvim',
					"nvim-neotest/neotest-plenary",
					"nvim-treesitter/nvim-treesitter",
					"antoinemadec/FixCursorHold.nvim",
					"nvim-neotest/neotest-python",
					"nvim-neotest/neotest-vim-test",
				},
				config = function()
					require("conf.vim-test")
					require("conf.neotest")
				end
			}
			-- cheatsheet
			use {
				'sudormrfbin/cheatsheet.nvim',
				requires = {
					{ 'nvim-telescope/telescope.nvim' },
					{ 'nvim-lua/popup.nvim' },
					{ 'nvim-lua/plenary.nvim' },
				},
				config = function() require("conf.cheatsheet") end
			}
			-- lua-line
			use {
				{
					'nvim-lualine/lualine.nvim',
					requires = { 'kyazdani42/nvim-web-devicons' },
					config = function() require("conf.lualine") end
				},
				{ 'nvim-lua/lsp-status.nvim', }
			}
			use {
				'simrat39/symbols-outline.nvim',
				config = function() require("conf.symbols-outline") end
			}
			-- telescope
			use {
				{
					"nvim-telescope/telescope.nvim",
					requires = { "nvim-lua/plenary.nvim" },
					config = function() require("conf.telescope") end
				},
				{ "nvim-telescope/telescope-smart-history.nvim", requires = { "kkharji/sqlite.lua" } },
				{ "nvim-telescope/telescope-dap.nvim", requires = { "mfussenegger/nvim-dap" } },
				{ "nvim-telescope/telescope-ui-select.nvim" },
				{ "nvim-telescope/telescope-packer.nvim" },
				{ "nvim-telescope/telescope-project.nvim" },
				{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
				{ "nvim-telescope/telescope-symbols.nvim" },
				{ 'nvim-telescope/telescope-z.nvim' },
				{ 'GustavoKatel/telescope-asynctasks.nvim' },
				{ 'dawsers/telescope-floaterm.nvim' },
			}
			-- treesitter
			use {
				{
					'nvim-treesitter/nvim-treesitter',
					run = ':TSUpdate',
					requires = {
						"p00f/nvim-ts-rainbow",
						"windwp/nvim-ts-autotag",
					},
					config = function() require("conf.nvim-treesitter") end
				},
				{ "Badhi/nvim-treesitter-cpp-tools" },
				{ "yioneko/nvim-yati" },
				{ 'nvim-treesitter/nvim-treesitter-context' }
			}
			-- autopairs
			use {
				"windwp/nvim-autopairs",
				config = function() require("conf.nvim-autopairs") end
			}
			use {
				"ur4ltz/surround.nvim",
				config = function()
					require "surround".setup { mappings_style = "sandwich" }
				end
			}
			-- indent_blankline
			use {
				"lukas-reineke/indent-blankline.nvim",
				config = function() require("conf.indent_blankline") end
			}
			-- comment
			use {
				'numToStr/Comment.nvim',
				requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
				config = function() require('conf.comment') end
			}
			-- lint
			use {
				'mfussenegger/nvim-lint',
				config = function() require("conf.nvim-lint") end
			}
			-- LSP
			use {
				{
					"neovim/nvim-lspconfig",
					config = function() require("conf.nvim-lspconfig") end
				},
				{
					"williamboman/mason.nvim",
					config = function() require("conf.mason") end
				},
				{ "williamboman/mason-lspconfig.nvim" },
				{ "folke/lua-dev.nvim" },
			}
			use {
				"ray-x/lsp_signature.nvim",
				config = function()
					require("conf.lsp_signature")
				end
			}
			-- nvim-cmp
			use {
				"hrsh7th/nvim-cmp",
				requires = {
					{ "onsails/lspkind-nvim" },
					{ "hrsh7th/cmp-nvim-lsp" },
					{ "hrsh7th/cmp-buffer" },
					{ "hrsh7th/cmp-path" },
					{ "hrsh7th/cmp-cmdline" },
					{ "f3fora/cmp-spell" },
					{
						"L3MON4D3/LuaSnip",
						config = function() require("luasnip.loaders.from_vscode").lazy_load() end
					},
					{ "saadparwaiz1/cmp_luasnip" },
					{ "rafamadriz/friendly-snippets" },
					{ "lukas-reineke/cmp-under-comparator" },
				},
				config = function() require("conf.nvim-cmp") end
			}
			-- debug
			use {
				{
					"mfussenegger/nvim-dap",
					config = function() require('conf.nvim-dap') end
				},
				{
					"rcarriga/nvim-dap-ui",
					config = function() require('conf.nvim-dap-ui') end
				},
				{
					"theHamsta/nvim-dap-virtual-text",
					requires = { "mfussenegger/nvim-dap", },
					config = function() require("conf.nvim-dap-virtual-text") end
				}
			}
			if packer_bootstrap then require('packer').sync() end
		end,
		config = {
			display = {
				open_fn = function() return require('packer.util').float({ border = 'single' }) end
			}
		},
	}
)
