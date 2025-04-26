return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
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

        local handlers = {
            ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
            ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
        }

        local on_attach = function(client, bufnr)
            -- hint
            if vim.lsp.inlay_hint then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
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
        end

        require("lspconfig").clangd.setup({
            handlers = handlers,
            on_attach = on_attach,
            cmd = {
                "clangd",
                "--clang-tidy",
                "--completion-style=bundled",
                "--cross-file-rename",
                "--fallback-style=LLVM",
                "--function-arg-placeholders=false",
                "--header-insertion=never",
                "--compile-commands-dir=build"
            },
            filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        })

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        local servers = {
            'rust_analyzer',
        }
        for _, lsp in ipairs(servers) do
            require 'lspconfig'[lsp].setup {
                handlers = handlers,
                on_attach = on_attach,
            }
        end
    end,
}
