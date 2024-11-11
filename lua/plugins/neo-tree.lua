return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "folke/snacks.nvim",
    },
    keys = {
        { "<leader>t", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
    },
    config = function()
        local events = require("neo-tree.events")
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
            event_handlers = {
                {
                    event = events.FILE_MOVED,
                    handler = function(data)
                        Snacks.rename.on_rename_file(data.source, data.destination)
                    end
                },
                {
                    event = events.FILE_RENAMED,
                    handler = function(data)
                        Snacks.rename.on_rename_file(data.source, data.destination)
                    end
                }
            }
        })
    end
}
