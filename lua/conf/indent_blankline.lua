-- https://github.com/lukas-reineke/indent-blankline.nvim
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    char = '¦', -- ['|', '¦', '┆', '┊']
    use_treesitter = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
    filetype_exclude = {
        "dashboard",
        "packer",
        "terminal",
        "help",
        "log",
        "markdown",
        "TelescopePrompt",
        "lsp-installer",
        "lspinfo",
        "toggleterm",
        "plugin"
    },
}
