return {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
        {
            "<leader>o",
            "<cmd>Outline<CR>",
            mode = "n",
            desc = "Toggle outline"
        },
    },
    config = function()
        require("outline").setup({
            symbols = {
                filter = { 'Function' }
            },
        })
    end
}
