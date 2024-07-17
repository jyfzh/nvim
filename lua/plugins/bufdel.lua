return {
    "ojroques/nvim-bufdel",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("bufdel").setup({
            next = "alternate", -- or 'cycle, 'alternate', 'tabs'
            quit = false,       -- quit Neovim when last buffer is closed
        })
    end,
}
