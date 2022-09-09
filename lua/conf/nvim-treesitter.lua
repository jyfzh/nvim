-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/p00f/nvim-ts-rainbow
-- https://github.com/Badhi/nvim-treesitter-cpp-tools
require("nvim-treesitter.configs").setup(
    {
        -- 安装的高亮支持来源
        ensure_installed = { "c", "cpp", "lua" },
        -- 同步下载高亮支持
        sync_install = false,
        -- 高亮相关
        highlight = {
            -- 启用高亮支持
            enable = true,
            -- 使用 treesitter 高亮而不是 neovim 内置的高亮
            additional_vim_regex_highlighting = false
        },
        -- 范围选择
        incremental_selection = {
            enable = true,
            keymaps = {
                -- 初始化选择
                init_selection = "<CR>",
                -- 递增
                node_incremental = "<CR>",
                -- 递减
                node_decremental = "<BS>",
                -- 选择一个范围
                scope_incremental = "<TAB>"
            }
        },
        indent = {
            enable = true
        },
        -- nvim-ts-rainbow
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        },
        -- nvim-ts-context-commentstring
        context_commentstring = {
            enable = true
        },
        nt_cpp_tools = {
            enable = true,
            preview = {
                quit = 'q', -- optional keymapping for quit preview
                accept = '<tab>' -- optional keymapping for accept preview
            },
            header_extension = 'h', -- optional
            source_extension = 'cxx', -- optional
            custom_define_class_function_commands = { -- optional
                TSCppImplWrite = {
                    output_handle = require 'nvim-treesitter.nt-cpp-tools.output_handlers'.get_add_to_cpp()
                }
                --[[
            <your impl function custom command name> = {
                output_handle = function (str, context) 
                    -- string contains the class implementation
                    -- do whatever you want to do with it
                end
            }
            ]]
            }
        }
    }
)
-- 开启 Folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99
