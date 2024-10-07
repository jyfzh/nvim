return {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
        {
            "<leader>o",
            "<cmd>Outline<CR>",
            mode = "n",
            desc = "Toggle outline"
        },
    },
    config = true
}
