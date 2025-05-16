return {
    'saghen/blink.cmp',
    dependencies = {
        "fang2hou/blink-copilot",
        after = { "copilot.lua" },
    } ,
    event = { "BufReadPost", "BufNewFile" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        cmdline = { 
            enabled = false ,
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
                enabled = true
            },
        },
        keymap = { preset = 'enter' },
        sources = {
            default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-copilot",
                    score_offset = 100,
                    async = true,
                },
            },
        },
        fuzzy = { implementation = "lua" }
    },
    opts_extend = { "sources.default" },
}
