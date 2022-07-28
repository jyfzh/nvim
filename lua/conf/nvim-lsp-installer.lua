-- https://github.com/williamboman/nvim-lsp-installer
-- local lsp_installer_servers = require("nvim-lsp-installer.servers")

require("nvim-lsp-installer").setup({
    -- automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

require("lsp.sumneko_lua")
require("lsp.clangd")
require("lsp.jdtls")
