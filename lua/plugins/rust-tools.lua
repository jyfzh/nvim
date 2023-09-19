return {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    dependencies = 'nvim-lspconfig',
    config = function()
        local rt = require("rust-tools")
        rt.setup({
            server = {
                on_attach = function(_, bufnr)
                    -- Hover actions
                    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                    -- Code action groups
                    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
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
                end,
            },
        })
    end
}
