return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        git = { enabled = false },
        gitbrowse = { enabled = false },
        lazygit = { enabled = false },
        styles = {
            notification = {
                wo = { wrap = true } -- Wrap notifications
            }
        }
    },
    keys = {
        { "<c-\\>", function() Snacks.terminal() end,         desc = "Toggle Terminal" },
        { "]]",     function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference" },
        { "[[",     function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                -- buffer delete
                vim.api.nvim_create_user_command(
                    'BufDelete',
                    "lua require('snacks').bufdelete()",
                    { bang = true, desc = "Delete Buffer" }
                )
                vim.api.nvim_create_user_command(
                    'BufDeleteAll',
                    "lua require('snacks').bufdelete.all()",
                    { desc = "Delete All Buffers" }
                )
                vim.api.nvim_create_user_command(
                    'BufDeleteOther',
                    "lua require('snacks').bufdelete.other()",
                    { desc = "Delete Other Buffers" }
                )
                -- Terminal
                vim.api.nvim_create_user_command(
                    'Terminal',
                    "lua require('snacks').terminal()",
                    { desc = "Toggle Terminal" }
                )
                -- rename
                vim.api.nvim_create_user_command(
                    'Rename',
                    "lua require('snacks').rename()",
                    { desc = "Rename File" }
                )
                vim.api.nvim_create_user_command(
                    'NotifyClear',
                    "lua require('snacks').notifier.hide()",
                    { desc = "Rename All Files" }
                )
            end,
        })
    end,
}
