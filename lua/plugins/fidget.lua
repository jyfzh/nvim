return {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
        notification = {
            window = {
                winblend = 0,
                max_width = math.floor(vim.api.nvim_win_get_width(0) / 3),
            },
        }
    },
}
