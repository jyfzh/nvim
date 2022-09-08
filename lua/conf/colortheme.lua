-- vim.cmd[[colorscheme tokyonight]]
-- https://github.com/navarasu/onedark.nvim
require("onedark").setup {
    transparent = true,
    term_colors = true, -- Change terminal color as per the selected theme style
    toggle_style_key = "<C-s>",
    code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },
    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {
        Normal = {bg = '0x000000'},
        -- TSKeyword = {fg = '$green'},
        -- TSString = {fmt = 'bold'},
        Pmenu          = { bg = 'NONE' },
        TSFunction     = { sp = '$cyan', fmt = 'bold' },
        -- lsp_signature
        NormalFloat    = { sp = 'NONE', bg = 'NONE' },
        FloatBorder    = { bg = 'NONE' },
        -- vim-floaterm
        Floaterm       = { bg = 'NONE' },
        FloatermBorder = { bg = 'NONE' },
        -- ts-rainbow
        -- rainbowcol1    = { fg = '#c678dd' },
    }, -- Override highlight groups
    diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = false, -- use undercurl instead of underline for diagnostics
        background = false, -- use background color for virtual text
    },
}
require "onedark".load()
