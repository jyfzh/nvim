return {
    "ojroques/nvim-bufdel",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("bufdel").setup({
            next = "alternate", -- or 'cycle, 'alternate', 'tabs'
            quit = false,       -- quit Neovim when last buffer is closed
        })
        vim.api.nvim_create_user_command("Bd", "BufDel",{})
        vim.api.nvim_create_user_command("Bda", "BufDelAll",{})
        vim.api.nvim_create_user_command("Bdo", "BufDelOther",{})
    end,
}
