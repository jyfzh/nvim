return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    event = { "BufReadPost", "BufNewFile" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'enter' },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "lua" }
    },
    opts_extend = { "sources.default" },
}
