-- https://github.com/nvim-neotest/neotest
-- https://github.com/nvim-neotest/neotest-vim-test
require("neotest").setup({
    adapters = {
        require("neotest-python")({
            dap = { justMyCode = false },
        }),
        require("neotest-plenary"),
        require("neotest-vim-test")({
            ignore_filetypes = { "python", "lua" },
        }),
    }
})
