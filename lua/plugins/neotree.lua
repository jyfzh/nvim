return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>t", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
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
                    leave_dirs_open = true,
                }
            }
        })
    end
}
