return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "folke/neodev.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
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
            virtual_text = { prefix = "", source = "always" }, -- prefix：'●', '▎', 'x'
            float = { source = "always" },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
            { border = "single" })

        local function switch_source_header_splitcmd(bufnr, splitcmd)
            bufnr = require("lspconfig").util.validate_bufnr(bufnr)
            local clangd_client = require("lspconfig").util.get_active_client_by_name(bufnr, "clangd")
            local params = { uri = vim.uri_from_bufnr(bufnr) }
            if clangd_client then
                clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
                    if err then
                        error(tostring(err))
                    end
                    if not result then
                        print("Corresponding file can’t be determined")
                        return
                    end
                    vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
                end, bufnr)
            else
                print(
                    "textDocument/switchSourceHeader is not supported by the clangd server active on the current buffer"
                )
            end
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
        capabilities.textDocument.completion.completionItem.preselectSupport = true
        capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
        capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
        capabilities.textDocument.completion.completionItem.deprecatedSupport = true
        capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
        capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
            },
        }

        local on_attach = function(client, bufnr)
            vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions

            if client.name == "clangd" then
                vim.keymap.set(
                    "n",
                    "<A-o>",
                    "<cmd>ClangdSwitchSourceHeader<CR>",
                    { noremap = true, silent = true, buffer = true, desc = "switch source header" }
                )
            end

            vim.keymap.set(
                "n",
                "gf",
                "<cmd>lua vim.lsp.buf.format { async = true }<CR>",
                { noremap = true, silent = true, buffer = bufnr, desc = "format" }
            )

            vim.keymap.set(
                "n",
                "gr",
                "<cmd>lua vim.lsp.buf.rename() <CR>",
                { noremap = true, silent = true, buffer = bufnr, desc = "rename" }
            )
            vim.keymap.set(
                "i",
                "<C-k>",
                vim.lsp.buf.signature_help,
                { noremap = true, silent = true, buffer = bufnr, desc = "signature_help" }
            )
        end

        require("neodev").setup()

        require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "lua-language-server", "--locale=zh-cn" },
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                        autoRequire = false,
                    },
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                        disable = {
                            "redefined-local",
                        },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                        -- https://github.com/neovim/nvim-lspconfig/issues/1700#issuecomment-1356282825
                        checkThirdParty = false,
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })


        -- https://clangd.llvm.org/features.html
        capabilities.offsetEncoding = { "utf-16" } -- https://github.com/neovim/neovim/pull/16694
        require("lspconfig").clangd.setup({
            on_attach = on_attach,
            capabilities = capabilities,
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
            },
            filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            init_options = {
                clangdFileStatus = true,
                usePlaceholders = false,
                completeUnimported = true,
                semanticHighlighting = true,
            },
            commands = {
                ClangdSwitchSourceHeader = {
                    function() switch_source_header_splitcmd(0, "edit") end,
                    description = "Open source/header in current buffer",
                },
                ClangdSwitchSourceHeaderVSplit = {
                    function() switch_source_header_splitcmd(0, "vsplit") end,
                    description = "Open source/header in a new vsplit",
                },
                ClangdSwitchSourceHeaderSplit = {
                    function() switch_source_header_splitcmd(0, "split") end,
                    description = "Open source/header in a new split",
                },
            },
        })

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        local servers = {
            'cmake',
            'pylsp',
            'ruff_lsp',
            'jsonls',
            'html',
            'cssls',
            'tsserver',
            'eslint',
            "powershell_es",
            "marksman",
        }
        for _, lsp in ipairs(servers) do
            require 'lspconfig'[lsp].setup {
                capabilities = capabilities,
                on_attach = on_attach,
            }
        end
    end,
}
