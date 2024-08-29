return {
    "ojroques/nvim-bufdel",
    event = "VeryLazy",
    opts = {
        next = "alternate",     -- or 'cycle, 'alternate', 'tabs'
        quit = false,           -- quit Neovim when last buffer is closed
    }
}
