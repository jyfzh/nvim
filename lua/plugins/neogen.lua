return {
    "danymat/neogen",
    keys = {
        { "gen", ":lua require('neogen').generate()<CR>", desc = "Generate Neogen" },
    },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
}

