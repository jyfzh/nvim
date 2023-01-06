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
			use "wbthomason/packer.nvim"
			use 'lewis6991/impatient.nvim'
			use 'navarasu/onedark.nvim'
			use { 'phaazon/hop.nvim', config = function() require("hop").setup() end }
			use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim",
				config = function() require("conf.todo-comments") end }
			use { "akinsho/toggleterm.nvim", config = function() require("conf.toggleterm") end }
			use { 'linty-org/key-menu.nvim', config = function() require("conf.key-menu") end }
			use { 'norcalli/nvim-colorizer.lua', config = function() require("conf.nvim-colorizer") end, }
			use { "jbyuki/venn.nvim", config = function() require("conf.venn") end }
			use { 'lewis6991/gitsigns.nvim', config = function() require("conf.gitsigns") end }
			use { 'tpope/vim-fugitive' }
			use {
				"nvim-neo-tree/neo-tree.nvim",
				requires = {
					{ "nvim-lua/plenary.nvim" },
					{ "kyazdani42/nvim-web-devicons" }, -- not strictly required, but recommended
					{ "MunifTanjim/nui.nvim" },
				},
				config = function() require("conf.neo-tree") end
			}
			use {
				'skywind3000/asyncrun.vim',
				requires = 'skywind3000/asynctasks.vim',
				config = function() vim.cmd [[  let g:asyncrun_open = 6 ]] end
			}
			use { "iamcco/markdown-preview.nvim", run = "cd app && npm install",
				setup = function() vim.g.mkdp_filetypes = { "markdown" } end, }

			use { 'kosayoda/nvim-lightbulb', config = function() require("conf.nvim-lightbulb") end }
			use { "ray-x/lsp_signature.nvim", config = function() require("conf.lsp_signature") end }
			use {
				'nvim-lualine/lualine.nvim',
				requires = {
					'kyazdani42/nvim-web-devicons',
					'nvim-lua/lsp-status.nvim',
				},
				config = function() require("conf.lualine") end
			}
			use { 'simrat39/symbols-outline.nvim', config = function() require("conf.symbols-outline") end }
			use { "windwp/nvim-autopairs", config = function() require("conf.nvim-autopairs") end }
			use { "ur4ltz/surround.nvim", config = function() require "surround".setup { mappings_style = "surround" } end }
			use { "lukas-reineke/indent-blankline.nvim", config = function() require("conf.indent_blankline") end }
			use { 'numToStr/Comment.nvim', config = function() require('conf.comment') end }
			use {
				"nvim-telescope/telescope.nvim",
				requires = {
					{ "nvim-lua/plenary.nvim" },
					{ "nvim-telescope/telescope-smart-history.nvim", requires = { "kkharji/sqlite.lua" } },
					{ "nvim-telescope/telescope-dap.nvim", requires = { "mfussenegger/nvim-dap" } },
					{ "nvim-telescope/telescope-ui-select.nvim" },
					{ "nvim-telescope/telescope-project.nvim" },
					{ 'nvim-telescope/telescope-fzf-native.nvim',
						run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
					},
					{ "nvim-telescope/telescope-symbols.nvim" },
					{ 'GustavoKatel/telescope-asynctasks.nvim' },
				},
				config = function() require("conf.telescope") end
			}
			use {
				'nvim-treesitter/nvim-treesitter',
				run = ':TSUpdate',
				requires = {
					"JoosepAlviste/nvim-ts-context-commentstring",
					"p00f/nvim-ts-rainbow",
					"windwp/nvim-ts-autotag",
					"Badhi/nvim-treesitter-cpp-tools",
					"yioneko/nvim-yati",
					'nvim-treesitter/nvim-treesitter-context'
				},
				config = function() require("conf.nvim-treesitter") end
			}
			use 'github/copilot.vim'
			use 'lervag/vimtex'
			use {
				"neovim/nvim-lspconfig",
				requires = {
					'nvim-lua/lsp-status.nvim',
					"williamboman/mason.nvim",
					"williamboman/mason-lspconfig.nvim",
					"folke/neodev.nvim",
					"mfussenegger/nvim-jdtls"
				},
				config = function()
					require("conf.mason")
					require("conf.nvim-lspconfig")
				end
			}
			use {
				"hrsh7th/nvim-cmp",
				requires = {
					"onsails/lspkind-nvim",
					"hrsh7th/cmp-nvim-lsp",
					"hrsh7th/cmp-buffer",
					"hrsh7th/cmp-path",
					"hrsh7th/cmp-cmdline",
					"L3MON4D3/LuaSnip",
					"saadparwaiz1/cmp_luasnip",
					"rafamadriz/friendly-snippets",
				},
				config = function() require("conf.nvim-cmp") end
			}
			use {
				{ "mfussenegger/nvim-dap", config = function() require('conf.nvim-dap') end },
				{ "rcarriga/nvim-dap-ui", config = function() require('conf.nvim-dap-ui') end },
				{ "theHamsta/nvim-dap-virtual-text", config = function() require("conf.nvim-dap-virtual-text") end },
			}
			use { 'mfussenegger/nvim-lint', config = function() require("conf.nvim-lint") end }
			use {
				"nvim-neotest/neotest",
				requires = {
					"vim-test/vim-test",
					'nvim-lua/plenary.nvim',
					"nvim-neotest/neotest-plenary",
					"nvim-treesitter/nvim-treesitter",
					"nvim-neotest/neotest-python",
					"nvim-neotest/neotest-vim-test",
				},
				config = function()
					require("conf.vim-test")
					require("conf.neotest")
				end
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
