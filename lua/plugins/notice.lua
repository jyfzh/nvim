return {
    "folke/noice.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "MunifTanjim/nui.nvim",
        -- { "rcarriga/nvim-notify", opts = { background_colour = "#000000" } }
    },
    opts = {
        cmline = {
            enabled = true,         -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            opts = {},              -- global options for the cmdline. See section on views
            ---@type table<string, CmdlineFormat>
            format = {
                cmdline = { pattern = "^:", icon = "", lang = "vim" },
                search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                input = {}, -- Used by input()
            },
        },
        messages = {
            -- NOTE: If you enable messages, then the cmdline is enabled automatically.
            -- This is a current Neovim limitation.
            enabled = true,              -- enables the Noice messages UI
            view = "notify",             -- default view for messages
            view_error = "notify",       -- view for errors
            view_warn = "notify",        -- view for warnings
            view_history = "messages",   -- view for :messages
            view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
        popupmenu = {
            enabled = true,  -- enables the Noice popupmenu UI
            ---@type 'nui'|'cmp'
            backend = "cmp", -- backend to use to show regular cmdline completions
            ---@type NoicePopupmenuItemKind|false
            -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
            kind_icons = {}, -- set to `false` to disable icons
        },
        -- default options for require('noice').redirect
        -- see the section on Command Redirection
        ---@type NoiceRouteConfig
        redirect = {
            view = "popup",
            filter = { event = "msg_show" },
        },
        -- You can add any custom commands below that will be available with `:Noice command`
        ---@type table<string, NoiceCommand>
        commands = {
            history = {
                -- options for the message history that you get with `:Noice`
                view = "split",
                opts = { enter = true, format = "details" },
                filter = {
                    any = {
                        { event = "notify" },
                        { error = true },
                        { warning = true },
                        { event = "msg_show", kind = { "" } },
                        { event = "lsp",      kind = "message" },
                    },
                },
            },
            -- :Noice last
            last = {
                view = "popup",
                opts = { enter = true, format = "details" },
                filter = {
                    any = {
                        { event = "notify" },
                        { error = true },
                        { warning = true },
                        { event = "msg_show", kind = { "" } },
                        { event = "lsp",      kind = "message" },
                    },
                },
                filter_opts = { count = 1 },
            },
            -- :Noice errors
            errors = {
                -- options for the message history that you get with `:Noice`
                view = "popup",
                opts = { enter = true, format = "details" },
                filter = { error = true },
                filter_opts = { reverse = true },
            },
        },
        notify = {
            enabled = true,
            view = "notify",
        },
        lsp = {
            progress = {
                enabled = true,
                -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
                -- See the section on formatting for more details on how to customize.
                --- @type NoiceFormat|string
                format = "lsp_progress",
                --- @type NoiceFormat|string
                format_done = "lsp_progress_done",
                throttle = 1000 / 30, -- frequency to update lsp progress message
                view = "mini",
            },
            override = {
                -- override the default lsp markdown formatter with Noice
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                -- override the lsp markdown formatter with Noice
                ["vim.lsp.util.stylize_markdown"] = true,
                -- override cmp documentation with Noice (needs the other options to work)
                ["cmp.entry.get_documentation"] = true,
            },
            hover = {
                enabled = true,
                silent = true, -- set to true to not show a message if hover is not available
                view = nil,    -- when nil, use defaults from documentation
                ---@type NoiceViewOptions
                opts = {},     -- merged with defaults from documentation
            },
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                    trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                    luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                    throttle = 50,  -- Debounce lsp signature help request by 50ms
                },
                view = nil,         -- when nil, use defaults from documentation
                ---@type NoiceViewOptions
                opts = {},          -- merged with defaults from documentation
            },
            message = {
                -- Messages shown by lsp servers
                enabled = true,
                view = "notify",
                opts = {},
            },
            -- defaults for hover and signature help
            documentation = {
                view = "hover",
                ---@type NoiceViewOptions
                opts = {
                    lang = "markdown",
                    replace = true,
                    render = "plain",
                    format = { "{message}" },
                    win_options = { concealcursor = "n", conceallevel = 3 },
                },
            },
        },
        markdown = {
            hover = {
                ["|(%S-)|"] = vim.cmd.help, -- vim help links
                -- ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
            },
            highlights = {
                ["|%S-|"] = "@text.reference",
                ["@%S+"] = "@parameter",
                ["^%s*(Parameters:)"] = "@text.title",
                ["^%s*(Return:)"] = "@text.title",
                ["^%s*(See also:)"] = "@text.title",
                ["{%S-}"] = "@parameter",
            },
        },
        health = {
            checker = false, -- Disable if you don't want health checks to run
        },
        smart_move = {
            -- noice tries to move out of the way of existing floating windows.
            enabled = true, -- you can disable this behaviour here
            -- add any filetypes here, that shouldn't trigger smart move.
            excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
        },
        throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
        ---@type NoiceConfigViews
        views = {
            cmdline_popup = {
                border = {
                    style = "single",
                    padding = { 0, 0 },
                },
                filter_options = {},
                win_options = {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                },
                position = {
                    row = 5,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
            },
            hover = {
                border = {
                    style = "single",
                },
                position = { row = 2, col = 2 },
            },
            popupmenu = {
                relative = "editor",
                position = {
                    row = 8,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
            },
            mini = {
                win_options = { winblend = 0 }
            }
        }, ---@see section on views
        ---@type NoiceRouteConfig[]
        routes = {
            {
                view = "notify",
                filter = { event = "msg_showmode" },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "search_count",
                },
                opts = { skip = true },
            },
        },           --- @see section on routes
        ---@type table<string, NoiceFilter>
        status = {}, --- @see section on statusline components
        ---@type NoiceFormatOptions
        format = {}, --- @see section on formatting
    }
}
