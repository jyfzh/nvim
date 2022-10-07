-- https://github.com/bthomason/packer.nvim

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
			-- theme
			use {
				'folke/tokyonight.nvim',
				'luisiacc/gruvbox-baby',
				'navarasu/onedark.nvim'
			}
			use {
				'rcarriga/nvim-notify',
	 			events = "VimEnter"
			}
			--  key-menu
			use {
				'linty-org/key-menu.nvim',
				events = "VimEnter",
				config = function() require("conf.key-menu") end
			}
			use {
				'norcalli/nvim-colorizer.lua',
				config = function() require("conf.nvim-colorizer") end,
				ft = { 'css', 'javascript', 'html' }
			}
			-- vim-floaterm
			use {
				'voldikss/vim-floaterm',
				events = "VimEnter",
				config = function()
					vim.cmd [[
						let g:floaterm_width = 0.8
						let g:floaterm_height = 0.8
						let g:floaterm_autoclose = 0
					]]
				end
			}
			--  draw
			use {
				"jbyuki/venn.nvim",
				events = "VimEnter",
				config = function() require("conf.venn") end
			}
			-- git
			use {
				'lewis6991/gitsigns.nvim',
				config = function() require("conf.gitsigns") end
			}
			-- neo-tree
			use {
				"nvim-neo-tree/neo-tree.nvim",
				events = "VimEnter",
				requires = {
					{ "nvim-lua/plenary.nvim" },
					{ "kyazdani42/nvim-web-devicons" }, -- not strictly required, but recommended
					{ "MunifTanjim/nui.nvim" },
				},
				config = function() require("conf.neo-tree") end
			}
			-- async
			use {
				'skywind3000/asyncrun.vim',
				requires = 'skywind3000/asynctasks.vim',
				config = function() vim.cmd [[  let g:asyncrun_open = 6 ]] end
			}
			use {
				"Shatur/neovim-session-manager",
				config = function() require("conf.neovim-session-manager") end
			}
			-- sniprun
			use {
				'michaelb/sniprun',
				run = './install.sh',
				config = function() require("conf.sniprun") end
			}
			-- [web-tools](https://github.com/ray-x/web-tools.nvim)
			use {
				"ray-x/web-tools.nvim",
				run = "npm install -g browser-sync",
				config = function() require 'web-tools'.setup() end
			}
			-- markdown-preview https://github.com/iamcco/markdown-preview.nvim
			use {
				"iamcco/markdown-preview.nvim",
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
					'nvim-telescope/telescope.nvim',
					'nvim-lua/popup.nvim',
					'nvim-lua/plenary.nvim',
				},
				config = function() require("conf.cheatsheet") end
			}
			-- lua-line
			use {
				'nvim-lualine/lualine.nvim',
				requires = {
					'kyazdani42/nvim-web-devicons',
					'nvim-lua/lsp-status.nvim',
				},
				config = function() require("conf.lualine") end
			}
			-- symbols-outline
			use {
				'simrat39/symbols-outline.nvim',
				config = function() require("conf.symbols-outline") end
			}
			-- hop.nvim
			use {
				'phaazon/hop.nvim',
				branch = 'v2',
				events = "VimEnter",
				config = function() require("conf.hop") end
			}
			-- autopairs
			use {
				"windwp/nvim-autopairs",
				config = function() require("conf.nvim-autopairs") end
			}
			-- [surround](https://github.com/ur4ltz/surround.nvim)
			use {
				"ur4ltz/surround.nvim",
				events = "BufEnter",
				config = function()
					require "surround".setup { mappings_style = "surround" }
				end
			}
			-- indent_blankline
			use {
				"lukas-reineke/indent-blankline.nvim",
				events = "BufEnter",
				config = function() require("conf.indent_blankline") end
			}
			-- comment
			use {
				'numToStr/Comment.nvim',
				events = "BufEnter",
				requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
				config = function() require('conf.comment') end
			}
			-- telescope
			use {
				"nvim-telescope/telescope.nvim",
				run = "sudo pacman -S fd repgrep sqlite3",
				requires = {
					{ "nvim-lua/plenary.nvim" },
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
				},
				config = function() require("conf.telescope") end
			}
			-- treesitter
			use {
				'nvim-treesitter/nvim-treesitter',
				run = ':TSUpdate',
				requires = {
					"p00f/nvim-ts-rainbow",
					"windwp/nvim-ts-autotag",
					"Badhi/nvim-treesitter-cpp-tools",
					"yioneko/nvim-yati",
					'nvim-treesitter/nvim-treesitter-context'
				},
				config = function() require("conf.nvim-treesitter") end
			}
			-- LSP
			use {
				"neovim/nvim-lspconfig",
				requires = {
					'nvim-lua/lsp-status.nvim',
					"williamboman/mason.nvim",
					"williamboman/mason-lspconfig.nvim",
					"folke/lua-dev.nvim",
				},
				config = function()
					require("conf.mason")
					require("conf.nvim-lspconfig")
				end
			}
			use {
				'kosayoda/nvim-lightbulb',
				config = function()
					require("conf.nvim-lightbulb")
				end
			}
			-- lsp_signature
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
					"onsails/lspkind-nvim",
					"hrsh7th/cmp-nvim-lsp",
					"hrsh7th/cmp-buffer",
					"hrsh7th/cmp-path",
					"hrsh7th/cmp-cmdline",
					"f3fora/cmp-spell",
					"L3MON4D3/LuaSnip",
					"saadparwaiz1/cmp_luasnip",
					"rafamadriz/friendly-snippets",
				},
				config = function() require("conf.nvim-cmp") end
			}
			-- debug
			use {
				{ "mfussenegger/nvim-dap", config = function() require('conf.nvim-dap') end },
				{ "rcarriga/nvim-dap-ui", config = function() require('conf.nvim-dap-ui') end },
				{ "theHamsta/nvim-dap-virtual-text", config = function() require("conf.nvim-dap-virtual-text") end },
			}
			-- lint
			use {
				'mfussenegger/nvim-lint',
				config = function() require("conf.nvim-lint") end
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
