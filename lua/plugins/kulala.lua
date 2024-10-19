return {
    'mistweaverco/kulala.nvim',
    keys = {
        {
            "<C-c><C-c>",
            "<cmd>lua require('kulala').run()<cr>",
            desc = "Run REST API",
            mode = "n",
        }
    },
    ft = { "http", "rest" },
    opts = {}
}
