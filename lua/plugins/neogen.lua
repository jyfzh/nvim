return {
    "danymat/neogen",
    config = function()
        require("neogen").setup()

        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "gnc", ":lua require('neogen').generate()<CR>", opts)
    end,
}
