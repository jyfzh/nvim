-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/nvim-lua/lsp-status.nvim
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = { "lua-language-server", "clangd", "cpptools", "pylsp", "marksman" },
    automatic_installation = true
})
