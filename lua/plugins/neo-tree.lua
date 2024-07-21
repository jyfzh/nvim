return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            window = {
                width = 30,
                auto_expand_width = false,
                mappings = {
                    ["<LeftMouse>"] = "open",
                }
            },
            filesystem = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                }
            },
            vim.keymap.set("n", "<leader>t", "<cmd>Neotree reveal toggle<CR>", { noremap = true, silent = true })
        })
    end
}
