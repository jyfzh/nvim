return {
    "neovim/nvim-lspconfig",
    dependencies = "williamboman/mason.nvim",
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
            -- SEE: clangd --help-hidden for possible options
            -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
            -- to add more `checks`, create  a `.clang-tidy` file in the root directory
            -- SEE: https://clang.llvm.org/extra/clang-tidy
            cmd = {
                "clangd",
                "--clang-tidy=true",
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

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        local servers = {
            'cmake',
            'pylsp',
            'rust_analyzer'
        }
        for _, lsp in ipairs(servers) do
            require 'lspconfig'[lsp].setup {
                on_attach = on_attach,
            }
        end
    end,
}
