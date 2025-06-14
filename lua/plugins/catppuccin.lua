return {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "VimEnter",
    config = function()
        require("catppuccin").setup({
            transparent_background = true,
            styles = {
                -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" },
                conditionals = { "bold" },
                loops = { "bold" },
                functions = { "bold" },
                keywords = { "bold" },
                strings = { "italic" },
                variables = {},
                numbers = { "italic" },
                booleans = { "italic" },
                properties = {},
                types = { "bold" },
                operators = { "bold" },
            },
            default_integrations = true,
            integrations = {
                neotree = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                        ok = { "italic" },
                    },
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "underdouble" },
                        warnings = { "underdashed" },
                        information = { "underdotted" },
                        ok = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                nvim_surround = true,
                fidget = true
            },
        })
        vim.cmd.colorscheme("catppuccin")
        vim.o.background = "light"
        vim.cmd [[hi LspInlayHint gui=italic]]
    end
}
