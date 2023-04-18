return {
    "kylechui/nvim-surround",
    dependencies = "tpope/vim-repeat",
    keys = { "cs", "ds", "ys" },
    config = function()
        require("nvim-surround").setup()
    end
}
