return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        {
            "<leader>t",
            "<cmd>Neotree reveal toggle<CR>",
            mode = { "n" },
            desc = "Toggle Neotree"
        }
    },
    config = function()
        require("neo-tree").setup({
            window = {
                width = 30,
                auto_expand_width = false,
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                }
            },
        })
    end
}
