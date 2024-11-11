return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = "screen"
    end,
    opts = {
        bottom = {
            -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
            {
                ft = "toggleterm",
                size = { height = 0.4 },
                -- exclude floating windows
                filter = function(buf, win)
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
            },
            {
                ft = "lazyterm",
                title = "LazyTerm",
                size = { height = 0.4 },
                filter = function(buf)
                    return not vim.b[buf].lazyterm_cmd
                end,
            },
            "Trouble",
            { ft = "qf",            title = "QuickFix" },
            {
                ft = "help",
                size = { height = 20 },
                -- only show help buffers
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
            { ft = "spectre_panel", size = { height = 0.4 } },
            {
                ft = "snacks_terminal",
                size = { height = 0.4 },
                title = "%{b:snacks_terminal.id}: %{b:term_title}",
                filter = function(_buf, win)
                    return vim.w[win].snacks_win
                        and vim.w[win].snacks_win.position == pos
                        and vim.w[win].snacks_win.relative == "editor"
                        and not vim.w[win].trouble_preview
                end,
            }
        },
        left = {
            -- Neo-tree filesystem always takes half the screen height
            {
                title = "Tree",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "filesystem"
                end,
                size = { height = 0.5 },
            },
            {
                title = function()
                    local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
                    return vim.fn.fnamemodify(buf_name, ":t")
                end,
                ft = "Outline",
                pinned = true,
                open = "SymbolsOutlineOpen",
            },
        },
        animate = { enabled = false },
        keys = {
            -- close window
            ["q"] = function(win)
                win:close()
            end,
            -- hide window
            ["<c-q>"] = function(win)
                win:hide()
            end,
            -- close sidebar
            ["Q"] = function(win)
                win.view.edgebar:close()
            end,
            -- next open window
            ["]w"] = function(win)
                win:next({ visible = true, focus = true })
            end,
            -- previous open window
            ["[w"] = function(win)
                win:prev({ visible = true, focus = true })
            end,
            -- next loaded window
            ["]W"] = function(win)
                win:next({ pinned = false, focus = true })
            end,
            -- prev loaded window
            ["[W"] = function(win)
                win:prev({ pinned = false, focus = true })
            end,
            -- increase width
            ["<c-w>>"] = function(win)
                win:resize("width", 2)
            end,
            -- decrease width
            ["<c-w><lt>"] = function(win)
                win:resize("width", -2)
            end,
            -- increase height
            ["<c-w>+"] = function(win)
                win:resize("height", 2)
            end,
            -- decrease height
            ["<c-w>-"] = function(win)
                win:resize("height", -2)
            end,
            -- reset all custom sizing
            ["<c-w>="] = function(win)
                win.view.edgebar:equalize()
            end,
        },
    },
}
