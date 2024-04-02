return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        require("ibl").setup({
            indent = { char = "┊" },
        })
        vim.cmd.highlight('clear @ibl.scope.underline.1')
    end
}
