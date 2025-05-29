return {
    'saghen/blink.cmp',
    event = { "BufReadPost", "BufNewFile" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        cmdline = { 
            enabled = true,
            completion = {
                menu = {
                    auto_show = true
                }
            },
        },
        completion = {
            keyword = {
                range = 'prefix'
            },
            ghost_text = {
                enabled = false 
            },
        },
        keymap = { preset = 'enter' },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "lua" }
    },
    opts_extend = { "sources.default" },
}
