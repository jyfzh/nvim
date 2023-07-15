return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        signs = {
            add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            change = {
                hl = "GitSignsChange",
                text = "│",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            delete = {
                hl = "GitSignsDelete",
                text = "_",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = "‾",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            changedelete = {
                hl = "GitSignsChange",
                text = "~",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = { enable = true },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            -- Navigation
            vim.keymap.set("n", "]g", function()
                if vim.wo.diff then
                    return "]g"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true })

            vim.keymap.set("n", "[g", function()
                if vim.wo.diff then
                    return "[g"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true })

            -- Actions
            vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "stage_hunk" })
            vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "reset_hunk" })
            vim.keymap.set("n", "<leader>hh", "<cmd>Gitsigns<CR>", { desc = "gitsigns" })
            vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "stage_buffer" })
            vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
            vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
            vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "preview_hunk" })
            vim.keymap.set("n", "<leader>hb", function()
                gs.blame_line({ full = true })
            end, { desc = "blame_line" })
            vim.keymap.set("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "toggle_current_line_blame" })
            vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "diffthis" })
            vim.keymap.set("n", "<leader>hD", function()
                gs.diffthis("~")
            end, { desc = "diffthis~" })
            vim.keymap.set("n", "<leader>htd", gs.toggle_deleted, { desc = "toggle_deleted" })

            -- Text object
            vim.keymap.set({ "o", "x" }, "<leader>ho", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select_hunk" })
        end,
    }
}
