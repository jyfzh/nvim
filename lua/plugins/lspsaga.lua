return {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
        require("lspsaga").setup({
            preview = {
                lines_above = 0,
                lines_below = 10,
            },
            scroll_preview = {
                scroll_down = "<C-f>",
                scroll_up = "<C-b>",
            },
            request_timeout = 2000,
            ui = {
                title = true,
                border = "single", -- Border type can be single, double, rounded, solid, shadow.
                winblend = 0,
                expand = "",
                collapse = "",
                code_action = "💡",
                incoming = " ",
                outgoing = " ",
                hover = ' ',
                kind = {},
            },
            finder = {
                max_height = 0.5,
                min_width = 30,
                force_max_height = false,
                keys = {
                    jump_to = nil,
                    expand_or_jump = '<cr>',
                    vsplit = 'v',
                    split = 's',
                    tabe = 't',
                    tabnew = 'n',
                    quit = { 'q', '<ESC>' },
                    close_in_preview = '<ESC>',
                },
            },
            definition = {
                edit = "<C-c>e",
                vsplit = "<C-c>v",
                split = "<C-c>s",
                tabe = "<C-c>t",
                quit = "q",
            },
            code_action = {
                num_shortcut = true,
                show_server_name = true,
                extend_gitsigns = true,
                keys = {
                    quit = { 'q', '<ESC>' },
                    exec = "<CR>",
                },
            },
            lightbulb = {
                enable = false,
                enable_in_insert = true,
                sign = true,
                sign_priority = 40,
                virtual_text = false,
            },
            hover = {
                max_width = 0.6,
                open_link = 'gx',
                open_browser = '!edge',
            },
            diagnostic = {
                on_insert = false,
                on_insert_follow = false,
                insert_winblend = 0,
                show_code_action = true,
                show_source = true,
                jump_num_shortcut = true,
                max_width = 0.7,
                max_height = 0.6,
                max_show_width = 0.9,
                max_show_height = 0.6,
                text_hl_follow = true,
                border_follow = true,
                extend_relatedInformation = false,
                keys = {
                    exec_action = 'o',
                    quit = { 'q', '<ESC>' },
                    expand_or_jump = '<CR>',
                    quit_in_show = { 'q', '<ESC>' },
                },
            },
            rename = {
                quit = "<C-c>",
                exec = "<CR>",
                mark = "x",
                confirm = "<CR>",
                in_select = true,
            },
            outline = {
                win_position = "right",
                win_with = "",
                win_width = 30,
                preview_width = 0.4,
                show_detail = true,
                auto_preview = true,
                auto_refresh = true,
                auto_close = true,
                custom_sort = nil,
                keys = {
                    expand_or_jump = '<cr>',
                    quit = "q",
                },
            },
            callhierarchy = {
                show_detail = false,
                keys = {
                    edit = "e",
                    vsplit = "s",
                    split = "i",
                    tabe = "t",
                    jump = "o",
                    quit = "q",
                    expand_collapse = "u",
                },
            },
            symbol_in_winbar = {
                enable = true,
                separator = ">",
                ignore_patterns = {},
                hide_keyword = true,
                show_file = true,
                folder_level = 2,
                respect_root = false,
                color_mode = true,
            },
        })

        vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>")
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
        vim.keymap.set("n", "gr", "<cmd>Lspsaga rename ++project<CR>")
        vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
        -- Use <C-t> to jump back
        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
        vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

        vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
        vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
        vim.keymap.set("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
        vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
        vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
        vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

        vim.keymap.set("n", "[E", function()
            require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end)
        vim.keymap.set("n", "]E", function()
            require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end)

        vim.keymap.set("n", "[W", function()
            require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARNING })
        end)
        vim.keymap.set("n", "]W", function()
            require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARNING })
        end)

        vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")

        -- Call hierarchy
        vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
        vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
    end
}
