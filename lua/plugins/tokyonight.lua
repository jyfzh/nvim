return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            style = "night",
            colors = {},
            hlgroups = {},
            integrations = {},
            options = {},
            plugins = {},
        })
        vim.o.background = "light"
        vim.cmd.colorscheme "tokyonight"
    end
}
