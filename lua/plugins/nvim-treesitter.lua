return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
        vim.wo.foldmethod = "expr"
        vim.wo.foldlevel = 99
        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

        for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
            config.install_info.url = config.install_info.url:gsub("https://github.com/",
                "https://mirror.ghproxy.com/https://github.com/")
        end

        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "rust" },
            sync_install = false,
            auto_install = true,
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

        vim.keymap.set("n", "[c", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { silent = true })
    end,
}
