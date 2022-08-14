require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup()
require("lsp.sumneko_lua")
require("lsp.clangd")
require("lsp.jdtls")
require("dap.cpptools")
