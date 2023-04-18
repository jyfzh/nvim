-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- https://github.com/folke/neodev.nvim

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
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "j-hui/fidget.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    enabled = _G.IsNotLargeFile(),
    config = function()
        local lsp_signature = require("lsp_signature")
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
            lsp_signature.on_attach(client, bufnr)
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
                "<A-S-F>",
                "<cmd>lua vim.lsp.buf.format { async = true }<CR>",
                { noremap = true, silent = true, buffer = bufnr, desc = "format" }
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
                    function() _G.Switch_source_header_splitcmd(0, "edit") end,
                    description = "Open source/header in current buffer",
                },
                ClangdSwitchSourceHeaderVSplit = {
                    function() _G.Switch_source_header_splitcmd(0, "vsplit") end,
                    description = "Open source/header in a new vsplit",
                },
                ClangdSwitchSourceHeaderSplit = {
                    function() _G.Switch_source_header_splitcmd(0, "split") end,
                    description = "Open source/header in a new split",
                },
            },
        })

        local servers = { 'cmake', 'rust_analyzer', 'pylsp', 'jsonls', 'html', 'cssls', 'tsserver', 'eslint' }
        for _, lsp in ipairs(servers) do
            require 'lspconfig'[lsp].setup {
                capabilities = capabilities,
                on_attach = on_attach,
            }
        end
    end,
}
