---@diagnostic disable: undefined-global
-- https://github.com/wbthomason/packer.nvim

local packer = require("packer")
packer.startup(
    {
        function(use)
            use {
                "wbthomason/packer.nvim"
            }
            -- 启动时间管理
            use {
                "tweekmonster/startuptime.vim"
            }
            -- theme
            use {
                { 'chxuan/change-colorscheme' },
                {
                    -- 'folke/tokyonight.nvim',
                    -- 'luisiacc/gruvbox-baby',
                    'navarasu/onedark.nvim',
                    config = function()
                    end
                },
            }
            -- vim-floaterm
            use {
                'voldikss/vim-floaterm',
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
                    requires = {
                        -- Lua 开发模块
                        { "nvim-lua/plenary.nvim" },
                    },
                    config = function()
                        require("conf.telescope")
                    end
                },
                { "nvim-telescope/telescope-file-browser.nvim" },
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
            -- use {
            --     "p00f/clangd_extensions.nvim",
            --     config = function()
            --         require("conf.clangd_extensions")
            --     end
            -- }
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
            -- use {
            --     'mfussenegger/nvim-lint',
            --     config = function ()
            --         require("conf.nvim-lint")
            --     end
            -- }
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
            use { {
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
