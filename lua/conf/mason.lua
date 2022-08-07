require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
Execute_path = vim.fn.stdpath'data'.."/mason/bin/"
require("lsp.sumneko_lua")
require("lsp.clangd")
require("lsp.jdtls")

require("dap.cpptools")
