return {
    "nvim-treesitter/nvim-treesitter",
    enabled = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "drybalka/tree-climber.nvim",
        { "danymat/neogen", config = true },
    },
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
        vim.wo.foldmethod = "expr"
        vim.wo.foldlevel = 99
        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

        for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
            config.install_info.url = config.install_info.url:gsub("https://github.com/",
                "https://ghfast.top/https://github.com/")
        end

        require("nvim-treesitter.configs").setup({
            ensure_installed = {},
            sync_install = false,
            auto_install = false,
            parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter",
            highlight = {
                enable = false,
            },
            incremental_selection = {
                enable = false,
            },
            indent = {
                enable = true,
            },
        })

        require 'treesitter-context'.setup {
            enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 5,            -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to show for a single context
            trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'topline',         -- Line used to calculate context. Choices: 'cursor', 'topline'
            separator = nil,
        }

        local keyopts = { noremap = true, silent = true }
        vim.keymap.set({ 'n', 'v', 'o' }, 'H', require('tree-climber').goto_parent, keyopts)
        vim.keymap.set({ 'n', 'v', 'o' }, 'L', require('tree-climber').goto_child, keyopts)
        vim.keymap.set({ 'n', 'v', 'o' }, 'J', require('tree-climber').goto_next, keyopts)
        vim.keymap.set({ 'n', 'v', 'o' }, 'K', require('tree-climber').goto_prev, keyopts)
        vim.keymap.set({ 'v', 'o' }, 'in', require('tree-climber').select_node, keyopts)
        vim.keymap.set('n', '<c-k>', require('tree-climber').swap_prev, keyopts)
        vim.keymap.set('n', '<c-j>', require('tree-climber').swap_next, keyopts)
        vim.keymap.set('n', '<c-h>', require('tree-climber').highlight_node, keyopts)
    end,
}
