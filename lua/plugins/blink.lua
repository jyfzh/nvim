return {
    'saghen/blink.cmp',
    dependencies = "fang2hou/blink-copilot" ,
    event = { "BufReadPost", "BufNewFile" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                treesitter_highlighting = false,
            },
            menu = {
                border = "single",
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
                    opts = {
                        max_completions = 1,
                        max_attempts = 2
                    }
                },
            },
        },
        fuzzy = { implementation = "lua" }
    },
    opts_extend = { "sources.default" },
}
