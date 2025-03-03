return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "SmiteshP/nvim-navic"
    },
    event = "VeryLazy",
    config = function()
        -- To instead override float border setting globally
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            local border = {
                { "┌", "FloatBorder" },
                { "─", "FloatBorder" },
                { "┐", "FloatBorder" },
                { "│", "FloatBorder" },
                { "┘", "FloatBorder" },
                { "─", "FloatBorder" },
                { "└", "FloatBorder" },
                { "│", "FloatBorder" },
            }
            opts = opts or {}
            opts.border = opts.border or border

            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
            { border = "single" })

        local on_attach = function(client, bufnr)
            -- hint
            if vim.lsp.inlay_hint then
                vim.defer_fn(function() vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end, 1000)
            end

            -- navic
            if client.server_capabilities.documentSymbolProvider then
                local navic = require("nvim-navic")
                navic.attach(client, bufnr)
                vim.wo.winbar =
                "%{%v:lua.require'nvim-navic'.get_location()%}"
            end

            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = bufnr,
                callback = function()
                    local opts = {
                        focusable = false,
                        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                        border = 'single',
                        source = 'always',
                        prefix = ' ',
                        scope = 'cursor',
                    }
                    vim.diagnostic.open_float(nil, opts)
                end
            })

            vim.keymap.set(
                "n",
                "gf",
                "<cmd>lua vim.lsp.buf.format { async = true }<CR>",
                { noremap = true, silent = true, buffer = bufnr, desc = "format" }
            )

            vim.keymap.set(
                "i",
                "<C-k>",
                vim.lsp.buf.signature_help,
                { noremap = true, silent = true, buffer = bufnr, desc = "signature_help" }
            )

            vim.keymap.set(
                "n",
                "gx",
                vim.lsp.buf.code_action,
                { noremap = true, silent = true, buffer = bufnr, desc = "code_action" }
            )

            vim.keymap.set(
                "n",
                "gd",
                vim.lsp.buf.definition,
                { noremap = true, silent = true, buffer = bufnr, desc = "definition" }
            )

            vim.keymap.set(
                "n",
                "gD",
                vim.lsp.buf.declaration,
                { noremap = true, silent = true, buffer = bufnr, desc = "declaration" }
            )

            vim.keymap.set(
                "n",
                "gi",
                vim.lsp.buf.implementation,
                { noremap = true, silent = true, buffer = bufnr, desc = "implementation" }
            )

            vim.keymap.set(
                "n",
                "gR",
                vim.lsp.buf.references,
                { noremap = true, silent = true, buffer = bufnr, desc = "references" }
            )

            vim.keymap.set(
                "n",
                "gs",
                vim.lsp.buf.document_symbol,
                { noremap = true, silent = true, buffer = bufnr, desc = "document_symbol" }
            )

            vim.keymap.set(
                "n",
                "gS",
                vim.lsp.buf.workspace_symbol,
                { noremap = true, silent = true, buffer = bufnr, desc = "workspace_symbol" }
            )

            vim.keymap.set(
                "n",
                "gr",
                vim.lsp.buf.rename,
                { noremap = true, silent = true, buffer = bufnr, desc = "rename" }
            )

            vim.keymap.set(
                "n",
                "<A-o>",
                "<cmd>ClangdSwitchSourceHeader<CR>",
                { noremap = true, silent = true, buffer = bufnr, desc = "clangd_switch_source_header" }
            )
            vim.keymap.set(
                "n",
                "]e",
                function()
                    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
                end,
                { noremap = true, silent = true, buffer = bufnr, desc = "next_error" }
            )
            vim.keymap.set(
                "n",
                "[e",
                function()
                    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
                end,
                { noremap = true, silent = true, buffer = bufnr, desc = "prev_error" }
            )

            vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
                group = vim.api.nvim_create_augroup("user_diagnostic_qflist", {}),
                callback = function(args)
                    -- Use pcall because I was getting inconsistent errors when quitting vim.
                    -- Possibly timing errors from trying to get/create diagnostics/qflists
                    -- that don't exist anymore. DiagnosticChanged fires at some strange times.
                    local has_diagnostics, diagnostics = pcall(vim.diagnostic.get)
                    local has_qflist, qflist = pcall(vim.fn.getqflist, { title = 0, id = 0, items = 0 })
                    if not has_diagnostics or not has_qflist then return end

                    -- Sometimes the event fires with an empty diagnostic list in the data.
                    -- This conditional prevents re-creating the qflist with the same
                    -- diagnostics, which reverts selection to the first item.
                    if
                        #args.data.diagnostics == 0
                        and #diagnostics > 0
                        and qflist.title == "All Diagnostics"
                        and #qflist.items == #diagnostics
                    then
                        return
                    end

                    vim.schedule(function()
                        -- If the last qflist was created by this autocmd, replace it so other
                        -- lists (e.g., vimgrep results) aren't buried due to diagnostic changes.
                        pcall(vim.fn.setqflist, {}, qflist.title == "All Diagnostics" and "r" or " ", {
                            title = "All Diagnostics",
                            items = vim.diagnostic.toqflist(diagnostics),
                        })

                        -- Don't steal focus from other qflists. For example, when working
                        -- through vimgrep results, you likely want :cnext to take you to the
                        -- next match, rather than the next diagnostic. Use :cnew to switch to
                        -- the diagnostic qflist when you want it.
                        if qflist.id ~= 0 and qflist.title ~= "All Diagnostics" then pcall(vim.cmd.cold) end
                    end)
                end,
            })
        end

        require("lspconfig").lua_ls.setup({
            on_attach = on_attach,
            cmd = { "lua-language-server", "--locale=zh-cn" },
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                        autoRequire = false
                    },
                    hint = {
                        enable = true, -- necessary
                    },
                    runtime = {
                        version = "LuaJIT"
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim", "jit" },
                        disable = { "redefined-local" }
                    },
                },
            },
        })

        require("lspconfig").clangd.setup({
            on_attach = on_attach,
            cmd = {
                "clangd",
                "--clang-tidy",
                "--completion-style=bundled",
                "--cross-file-rename",
                "--fallback-style=LLVM",
                "--function-arg-placeholders=false",
                "--header-insertion=never",
                "--offset-encoding=utf-16", -- https://github.com/neovim/neovim/pull/16694
                "--compile-commands-dir=build"
            },
            filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        })

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        local servers = {
            'pylsp',
            'rust_analyzer',
        }
        for _, lsp in ipairs(servers) do
            require 'lspconfig'[lsp].setup {
                on_attach = on_attach,
            }
        end
    end,
}
