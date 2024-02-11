return {
    "kkharji/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
        require("lspsaga").setup({
            error_sign = "",
            warn_sign = "",
            hint_sign = "",
            infor_sign = "",
            diagnostic_header_icon = "   ",
            code_action_icon = "",
            code_action_prompt = {
                enable = true,
                sign = true,
                sign_priority = 40,
                virtual_text = false,
            },
        })

        local opts = { silent = true, noremap = true };

        vim.keymap.set("n", "<C-k>", "<cmd>Lspsaga signature_help<CR>", opts)
        vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
        vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
        vim.keymap.set("n", "gi", "<cmd>Lspsaga implement<CR>", opts)
        vim.keymap.set("n", "gx", "<cmd>Lspsaga code_action<CR>", opts)
        vim.keymap.set("x", "gx", ":<c-u>Lspsaga range_code_action<CR>", opts)
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
        vim.keymap.set("n", "gp", "<cmd>Lspsaga preview_definition<CR>", opts)
        -- vim.keymap.set("n", "go", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
        vim.keymap.set("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
        vim.keymap.set("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

        vim.keymap.set("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", opts)
        vim.keymap.set("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", opts)
    end
}
