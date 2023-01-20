-- https://github.com/nvim-lualine/lualine.nvim

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
        "nvim-lua/lsp-status.nvim",
    },
    event = "BufRead",
    config = function()
        vim.keymap.set(
            "n",
            "<A-1>",
            "<cmd>LualineBuffersJump! 1<CR>",
            { noremap = true, silent = true, desc = "buffer jump 1" }
        )
        vim.keymap.set(
            "n",
            "<A-2>",
            "<cmd>LualineBuffersJump! 2<CR>",
            { noremap = true, silent = true, desc = "buffer jump 2" }
        )
        vim.keymap.set(
            "n",
            "<A-3>",
            "<cmd>LualineBuffersJump! 3<CR>",
            { noremap = true, silent = true, desc = "buffer jump 3" }
        )
        vim.keymap.set(
            "n",
            "<A-4>",
            "<cmd>LualineBuffersJump! 4<CR>",
            { noremap = true, silent = true, desc = "buffer jump 4" }
        )
        vim.keymap.set(
            "n",
            "<A-5>",
            "<cmd>LualineBuffersJump! 5<CR>",
            { noremap = true, silent = true, desc = "buffer jump 5" }
        )
        vim.keymap.set(
            "n",
            "<A-6>",
            "<cmd>LualineBuffersJump! 6<CR>",
            { noremap = true, silent = true, desc = "buffer jump 6" }
        )
        vim.keymap.set(
            "n",
            "<A-7>",
            "<cmd>LualineBuffersJump! 7<CR>",
            { noremap = true, silent = true, desc = "buffer jump 7" }
        )
        vim.keymap.set(
            "n",
            "<A-8>",
            "<cmd>LualineBuffersJump! 8<CR>",
            { noremap = true, silent = true, desc = "buffer jump 8" }
        )
        vim.keymap.set(
            "n",
            "<A-9>",
            "<cmd>LualineBuffersJump! 9<CR>",
            { noremap = true, silent = true, desc = "buffer jump 9" }
        )
        vim.keymap.set(
            "n",
            "<A-$>",
            "<cmd>LualineBuffersJump! $<CR>",
            { noremap = true, silent = true, desc = "buffer jump last" }
        )
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { statusline = {} },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 300,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {},
                lualine_c = { "branch", "diff" },
                lualine_x = {
                    { "require('lsp-status').status()" },
                    "encoding",
                    { "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } },
                    "filetype",
                },
                lualine_y = {},
                lualine_z = { "progress" },
            },
            tabline = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "buffers", mode = 2, icons_enabled = true } },
                lualine_x = { "tabs" },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "quickfix", "nvim-dap-ui", "symbols-outline", "neo-tree", "man", "toggleterm", "fugitive" },
        })
    end,
}
