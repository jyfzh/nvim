-- @diagnostic disable: undefined-global
-- https://github.com/wbthomason/packer.nvim
-- use {
--   'myusername/example',        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When requiring a string which matches one of these patterns, the plugin will be loaded.
-- }
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
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
            -- 启动时间管理
            use {
                "tweekmonster/startuptime.vim",
            }
            -- theme
            use {
                -- 'folke/tokyonight.nvim',
                -- 'luisiacc/gruvbox-baby',
                'navarasu/onedark.nvim',
            }
            -- vim-floaterm
            use {
                'voldikss/vim-floaterm',
            }
            -- nvim-tree
            use {
                'kyazdani42/nvim-tree.lua',
                requires = {
                    'kyazdani42/nvim-web-devicons', -- optional, for file icons
                },
                tag = 'nightly', -- optional, updated every week. (see issue #1193)
                config = function()
                    require("conf.nvim-tree")
                end
            }
            -- hydra
            use {
                'anuvyklack/hydra.nvim',
                config = function()
                    require("conf.hydra")
                end
            }
            -- notify
            use {
                'rcarriga/nvim-notify',
            }
            --  draw
            use {
                "jbyuki/venn.nvim",
                config = function()
                    require("conf.venn")
                end
            }
            use {
                'lewis6991/gitsigns.nvim',
                config = function()
                    require("conf.gitsigns")
                end
            }
            -- code_runner
            use {
                {
                    'CRAG666/code_runner.nvim',
                    requires = 'nvim-lua/plenary.nvim',
                    config = function()
                        require("conf.code_runner")
                    end
                },
                {
                    'michaelb/sniprun',
                    run = 'bash ./install.sh',
                    config = function()
                        require("conf.sniprun")
                    end
                }
            }
            use {
                'sudormrfbin/cheatsheet.nvim',
                requires = {
                    { 'nvim-telescope/telescope.nvim' },
                    { 'nvim-lua/popup.nvim' },
                    { 'nvim-lua/plenary.nvim' },
                },
                config = function()
                    require("conf.cheatsheet")
                end
            }
            -- lua-line
            use { {
                'nvim-lualine/lualine.nvim',
                requires = { 'kyazdani42/nvim-web-devicons', opt = true },
                config = function()
                    require("conf.lualine")
                end
            },
                { 'nvim-lua/lsp-status.nvim', }
            }
            -- 模糊查找
            use {
                {
                    "nvim-telescope/telescope.nvim",
                    -- event = "VimEnter",
                    requires = {
                        -- Lua 开发模块
                        { "nvim-lua/plenary.nvim" },
                    },
                    config = function()
                        require("conf.telescope")
                    end
                },
                { "nvim-telescope/telescope-ui-select.nvim" },
                { "nvim-telescope/telescope-packer.nvim" },
                { "nvim-telescope/telescope-project.nvim" },
                { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
                { "nvim-telescope/telescope-dap.nvim", requires = { "mfussenegger/nvim-dap" } },
                { "nvim-telescope/telescope-symbols.nvim" },
                {
                    "nvim-telescope/telescope-smart-history.nvim",
                    requires = { "kkharji/sqlite.lua" }
                },
                {
                    "nvim-telescope/telescope-frecency.nvim",
                    config = function()
                        require "telescope".load_extension("frecency")
                    end,
                    requires = { "kkharji/sqlite.lua" }
                },
            }
            -- treesitter
            use {
                {
                    'nvim-treesitter/nvim-treesitter',
                    run = ':TSUpdate',
                    requires = {
                        "p00f/nvim-ts-rainbow"
                    },
                    config = function()
                        require("conf.nvim-treesitter")
                    end
                },
                {
                    "Badhi/nvim-treesitter-cpp-tools",
                    requires = { "nvim-treesitter/nvim-treesitter" },
                }
            }
            -- 自动匹配括号
            use {
                "windwp/nvim-autopairs",
                after = "nvim-treesitter",
                config = function()
                    require("conf.nvim-autopairs")
                end
            }
            -- indent_vlankline
            use {
                "lukas-reineke/indent-blankline.nvim",
                config = function()
                    require("conf.indent_blankline")
                end
            }
            -- comment
            use {
                'numToStr/Comment.nvim',
                requires = {
                    "JoosepAlviste/nvim-ts-context-commentstring"
                },
                config = function()
                    require('conf.comment')
                end
            }
            -- lint
            use {
                'mfussenegger/nvim-lint',
                config = function()
                    require("conf.nvim-lint")
                end
            }
            -- navic
            use {
                "SmiteshP/nvim-navic",
                requires = "neovim/nvim-lspconfig",
                config = function()
                    require("conf.nvim-navic")
                end
            }
            use {
                'simrat39/symbols-outline.nvim',
                config = function()
                    require("conf.symbols-outline")
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
                { "williamboman/mason-lspconfig.nvim" },
            }
            -- LSP UI 美化
            use {
                -- 插入模式获得函数签名
                "ray-x/lsp_signature.nvim",
                config = function()
                    require("conf.lsp_signature")
                end
            }
            -- 自动代码补全
            use {
                "hrsh7th/nvim-cmp", -- 代码补全核心插件，下面都是增强补全的体验插件
                requires = {
                    { "onsails/lspkind-nvim" }, -- 为补全添加类似 vscode 的图标
                    { "hrsh7th/cmp-nvim-lsp" }, -- 替换内置 omnifunc，获得更多补全
                    { "hrsh7th/cmp-buffer" }, -- 缓冲区补全
                    { "hrsh7th/cmp-path" }, -- 路径补全
                    { "hrsh7th/cmp-cmdline" }, -- 命令补全
                    {
                        "L3MON4D3/LuaSnip",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end
                    },
                    { "saadparwaiz1/cmp_luasnip" },
                    { "rafamadriz/friendly-snippets" },
                    { "f3fora/cmp-spell" }, -- 拼写建议
                    { "lukas-reineke/cmp-under-comparator" }, -- 让补全结果的排序更加智能
                },
                config = function()
                    require("conf.nvim-cmp")
                end
            }
            -- debug
            use { {
                "mfussenegger/nvim-dap",
                config = function()
                    require('conf.nvim-dap')
                end
            },
                {
                    "rcarriga/nvim-dap-ui",
                    config = function()
                        require('conf.nvim-dap-ui')
                    end
                },
                {
                    "theHamsta/nvim-dap-virtual-text",
                    requires = {
                        "mfussenegger/nvim-dap",
                    },
                    config = function()
                        require("conf.nvim-dap-virtual-text")
                    end
                }
            }
            if packer_bootstrap then
                require('packer').sync()
            end
        end,
        -- 使用浮动窗口
        config = {
            display = {
                open_fn = function()
                    return require('packer.util').float({ border = 'single' })
                end
            }
        },
    }
)
