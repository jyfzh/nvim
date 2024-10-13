return {
    "ojroques/nvim-bufdel",
    cmd = { "BufDel", "BufDelAll", "BufDelOthers" },
    opts = {
        next = "alternate", -- or 'cycle, 'alternate', 'tabs'
        quit = false,       -- quit Neovim when last buffer is closed
    }
}
