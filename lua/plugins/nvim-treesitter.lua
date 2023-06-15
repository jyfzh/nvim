-- https://github.com/nvim-treesitter/nvim-treesitter

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
        "nvim-treesitter/playground",
        "Badhi/nvim-treesitter-cpp-tools",
    },
    init = function ()
        vim.wo.foldmethod = "expr"
        vim.wo.foldlevel = 99
        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
    end,
    config = function()
        -- https://github.com/p00f/nvim-ts-rainbow/issues/81#issuecomment-1058124957
        local rainbow = { "#CC8888", "#CCCC88", "#88CC88", "#88CCCC", "#8888CC", "#CC88CC" }
        for i, c in ipairs(rainbow) do
            vim.cmd(("hi rainbowcol%d guifg=%s"):format(i, c))
        end

        -- proxy
        for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
            config.install_info.url = config.install_info.url:gsub("https://github.com/",
                "https://ghproxy.com/https://github.com/")
        end

        require("nvim-treesitter.configs").setup({
            -- HACK:
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
            context_commentstring = {
                enable = true
            },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = "o",
                    toggle_hl_groups = "i",
                    toggle_injected_languages = "t",
                    toggle_anonymous_nodes = "a",
                    toggle_language_display = "I",
                    focus_language = "f",
                    unfocus_language = "F",
                    update = "R",
                    goto_node = "<cr>",
                    show_help = "?",
                },
            },
        })
    end,
}
