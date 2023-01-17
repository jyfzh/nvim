-- https://github.com/folke/lazy.nvim

-- @diagnostic disable: undefined-global
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("conf.onedark")
			require("onedark").load()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "BufRead",
		config = function()
			require("conf.todo-comments")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("conf.toggleterm")
		end,
	},
	{
		"linty-org/key-menu.nvim",
		event = "BufRead",
		config = function()
			require("conf.key-menu")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("conf.nvim-colorizer")
		end,
	},
	{
		"jbyuki/venn.nvim",
		config = function()
			require("conf.venn")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("conf.gitsigns")
		end,
	},
	{ "tpope/vim-fugitive", event = "BufRead" },
	{
		"nvim-orgmode/orgmode",
		ft = "org",
		config = function()
			require("conf.orgmode")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "kyazdani42/nvim-web-devicons" },
			{ "MunifTanjim/nui.nvim" },
		},
		event = "BufRead",
		config = function()
			require("conf.neo-tree")
		end,
	},
	{
		"skywind3000/asyncrun.vim",
		dependencies = "skywind3000/asynctasks.vim",
		event = "BufRead",
		config = function()
			vim.g.asyncrun_open = 6
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},

	{
		"kosayoda/nvim-lightbulb",
		event = "BufRead",
		config = function()
			require("conf.nvim-lightbulb")
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("conf.lsp_signature")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
			"nvim-lua/lsp-status.nvim",
		},
		config = function()
			require("conf.lualine")
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("conf.symbols-outline")
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("conf.nvim-autopairs")
		end,
	},
	{
		"ur4ltz/surround.nvim",
		event = "BufRead",
		config = function()
			require("surround").setup({ mappings_style = "surround" })
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("conf.indent_blankline")
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "BufRead",
		config = function()
			require("conf.comment")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-smart-history.nvim", dependencies = { "kkharji/sqlite.lua" } },
			{ "nvim-telescope/telescope-dap.nvim", dependencies = { "mfussenegger/nvim-dap" } },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-project.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{ "nvim-telescope/telescope-symbols.nvim" },
			{ "GustavoKatel/telescope-asynctasks.nvim" },
		},
		config = function()
			require("conf.telescope")
		end,
	},
	{
		"Badhi/nvim-treesitter-cpp-tools",
		dependencies = "nvim-treesitter",
		ft = "cpp",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"p00f/nvim-ts-rainbow",
			"windwp/nvim-ts-autotag",
			"yioneko/nvim-yati",
			"nvim-treesitter/nvim-treesitter-context",
		},
		event = "BufRead",
		config = function()
			require("conf.nvim-treesitter")
		end,
	},
	{ "github/copilot.vim", event = "BufRead" },
	{ "lervag/vimtex", ft = "tex" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"jay-babu/mason-null-ls.nvim",
			"williamboman/mason.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("conf.null-ls")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-lua/lsp-status.nvim",
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			"mfussenegger/nvim-jdtls",
		},
		event = "BufRead",
		config = function()
			require("conf.mason")
			require("conf.nvim-lspconfig")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind-nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		event = "InsertEnter",
		config = function()
			require("conf.nvim-cmp")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("conf.nvim-dap-ui")
			require("conf.nvim-dap")
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		event = "BufRead",
		config = function()
			require("conf.nvim-dap-virtual-text")
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"vim-test/vim-test",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/neotest-plenary",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-vim-test",
		},
		event = "BufRead",
		config = function()
			require("conf.vim-test")
			require("conf.neotest")
		end,
	},
}

local settings = {
	root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
	defaults = {
		lazy = false, -- should plugins be lazy-loaded?
		version = "*",
		-- version = "*", -- enable this to try installing the latest stable versions of plugins
	},
	-- leave nil when passing the spec as the first argument to setup()
	spec = nil, ---@type LazySpec
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
	concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
	git = {
		-- defaults for the `Lazy log` command
		-- log = { "-10" }, -- show the last 10 commits
		log = { "--since=3 days ago" }, -- show commits from the last 3 days
		timeout = 120, -- kill processes that take more than 2 minutes
		url_format = "https://ghproxy.com/https:/github.com/%s.git",
	},
	dev = {
		-- directory where you store your local plugin projects
		path = "~/projects",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = {}, -- For example {"folke"}
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "onedark" },
	},
	ui = {
		-- a number <1 is a percentage., >1 is a fixed size
		size = { width = 0.8, height = 0.8 },
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "none",
		icons = {
			cmd = " ",
			config = "",
			event = "",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "鈴 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			source = " ",
			start = "",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
		-- leave nil, to automatically select a browser depending on your OS.
		-- If you want to use a specific browser, you can define it here
		browser = nil, ---@type string?
		throttle = 20, -- how frequently should the ui process render events
		custom_keys = {
			-- you can define custom key maps here.
			-- To disable one of the defaults, set it to false

			-- open lazygit log
			["<localleader>l"] = function(plugin)
				require("lazy.util").float_term({ "lazygit", "log" }, {
					cwd = plugin.dir,
				})
			end,

			-- open a terminal for the plugin dir
			["<localleader>t"] = function(plugin)
				require("lazy.util").float_term(nil, {
					cwd = plugin.dir,
				})
			end,
		},
	},
	diff = {
		-- diff command <d> can be one of:
		-- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
		--   so you can have a different command for diff <d>
		-- * git: will run git diff and open a buffer with filetype git
		-- * terminal_git: will open a pseudo terminal with git diff
		-- * diffview.nvim: will open Diffview to show the diff
		cmd = "diffviewgit",
	},
	checker = {
		-- automatically check for plugin updates
		enabled = false,
		concurrency = 10, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = true, -- get a notification when changes are found
	},
	performance = {
		cache = {
			enabled = true,
			path = vim.fn.stdpath("cache") .. "/lazy/cache",
			-- Once one of the following events triggers, caching will be disabled.
			-- To cache all modules, set this to `{}`, but that is not recommended.
			-- The default is to disable on:
			--  * VimEnter: not useful to cache anything else beyond startup
			--  * BufReadPre: this will be triggered early when opening a file from the command line directly
			disable_events = { "UIEnter", "BufReadPre" },
			ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
			---@type string[]
			paths = {}, -- add any custom paths here that you want to indluce in the rtp
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
			},
		},
	},
	-- lazy can generate helptags from the headings in markdown readme files,
	-- so :help works even for plugins that don't have vim docs.
	-- when the readme opens with :help it will be correctly displayed as markdown
	readme = {
		root = vim.fn.stdpath("state") .. "/lazy/readme",
		files = { "README.md", "lua/**/README.md" },
		-- only generate markdown helptags for plugins that dont have docs
		skip_if_doc_exists = true,
	},
}

require("lazy").setup(plugins, settings)
