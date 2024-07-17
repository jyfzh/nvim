return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "p00f/nvim-ts-rainbow",
        "windwp/nvim-ts-autotag",
        "yioneko/nvim-yati",
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-refactor",
        "Badhi/nvim-treesitter-cpp-tools",
    },
    config = function()
        vim.wo.foldmethod = "expr"
        vim.wo.foldlevel = 99
        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

        for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
            config.install_info.url = config.install_info.url:gsub("https://github.com/",
                "https://mirror.ghproxy.com/https://github.com/")
        end

        -- https://github.com/p00f/nvim-ts-rainbow/issues/81#issuecomment-1058124957
        local rainbow = { "#CC8888", "#CCCC88", "#88CC88", "#88CCCC", "#8888CC", "#CC88CC" }
        for i, c in ipairs(rainbow) do
            vim.cmd(("hi rainbowcol%d guifg=%s"):format(i, c))
        end

        require("nvim-treesitter.configs").setup({
            parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter",
            ensure_installed = {},
            sync_install = true,
            highlight = {
                enable = true,
                disable = {},
                additional_vim_regex_highlighting = { "org" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    node_decremental = "<BS>",
                    scope_incremental = nil,
                },
            },
            indent = {
                enable = false,
                disable = {},
            },
            yati = {
                enable = true,
            },
            autotag = {
                enable = true,
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
                colors = rainbow,     -- table of hex strings
                termcolors = rainbow, --table of colour name strings
            },
            refactor = {
                highlight_definitions = {
                    enable = true,
                    -- Set to false if you have an `updatetime` of ~100.
                    clear_on_cursor_move = false,
                },
                highlight_current_scope = { enable = false },
                smart_rename = {
                    enable = false,
                    -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
                    keymaps = {
                        smart_rename = "grr",
                    },
                },
                navigation = {
                    enable = false,
                    -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
                    keymaps = {
                        goto_definition = "gnd",
                        list_definitions = "gnD",
                        list_definitions_toc = "gO",
                        goto_next_usage = "<a-*>",
                        goto_previous_usage = "<a-#>",
                    },
                },
            },
        })
    end,
}
