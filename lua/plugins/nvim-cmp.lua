return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "onsails/lspkind.nvim",
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "zbirenbaum/copilot-cmp",
    },
    config = function()
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local cmp = require("cmp")
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
        cmp.setup({
            view = {
                entries = { name = "custom", selection_order = "near_cursor" },
            },
            window = {
                documentation = cmp.config.window.bordered(),
                completion = {
                    scrolloff = 10,
                    -- border = 'rounded',
                },
            },
            completion = {
                completeopt = "menu,menuone,select",
            },
            experimental = {
                ghost_text = true, -- this feature conflict with copilot.vim's preview.
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    elseif require("luasnip").locally_jumpable(-1) then
                        require("luasnip").jump(-1)
                    elseif has_words_before() then
                        cmp.complete()
                    end
                end, { "i", "s" }),
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    elseif require("luasnip").locally_jumpable(1) then
                        require("luasnip").jump(1)
                    end
                end, { "i", "s" }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if require("luasnip").expandable() then
                            require("luasnip").expand()
                        else
                            cmp.confirm({
                                select = true,
                            })
                        end
                    else
                        fallback()
                    end
                end),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "copilot" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "path" },
                { name = "buffer" },
            }),
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol_text",
                    with_text = true,
                    maxwidth = 50,
                    before = function(entry, vim_item)
                        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                        if string.upper(entry.source.name) == "COPILOT" then
                            vim_item.kind = " Copilot"
                        end
                        return vim_item
                    end,
                }),
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    require("copilot_cmp.comparators").prioritize,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    -- cmp.config.compare.scopes,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        })
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            sources = {
                { name = "buffer" },
            },
        })
    end,
}
