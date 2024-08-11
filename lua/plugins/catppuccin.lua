return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
            flavour = "auto", -- latte, frappe, macchiato, mocha
            background = {
                light = "latte",
                dark = "macchiato",
            },
            transparent_background = true, -- disables setting the background color.
            show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
            term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false,           -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15,         -- percentage of the shade to apply to the inactive window
            },
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
                properties = { },
                types = { "bold" },
                operators = { "bold" },
            },
            color_overrides = {},
            custom_highlights = {},
            default_integrations = true,
            integrations = {
                mason = true,
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
                navic = {
                    enabled = true,
                    custom_bg = "NONE",
                },
                nvim_surround = true
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end
}
