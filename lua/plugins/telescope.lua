return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-project.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
    event = "VeryLazy",
    config = function()
        require("telescope").setup({
            defaults = {
                border = false,
                winblend = 0,
                dynamic_preview_title = true,
                path_display = { "truncate" },
                layout_strategy = "bottom_pane",
                sorting_strategy = "ascending",
                vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--trim" },
                file_ignore_patterns = {
                    "^.git",
                    ".cache",
                    "3rdparty",
                    "build",
                    "node_modules"
                },
                mappings = {
                    i = {
                        ["<C-f>"] = require("telescope.actions").preview_scrolling_down,
                        ["<C-b>"] = require("telescope.actions").preview_scrolling_up,
                        ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
                        ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
                        ["<C-q>"] = require("telescope.actions").smart_send_to_qflist
                            + require("telescope.actions").open_qflist,
                        ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
                    },
                    n = {
                        ["p"] = require("telescope.actions.layout").toggle_preview,
                    },
                },
            },
            pickers = {
                find_files = {
                    prompt_title = "Find File",
                    hidden = true,
                    find_command = { "fd", "--type", "f", "--color", "never", "-E", ".git" },
                },
            },
            extensions = {
                project = {
                    theme = "dropdown",
                    hidden_files = true,
                    order_by = "asc",
                    base_dirs = {},
                    mappings = {},
                },
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case",the default case_mode is "smart_case"
                },
                ["ui-select"] = {
                    require("telescope.themes").get_ivy {
                        layout_config = {
                            prompt_position = "bottom",
                            height = 0.3,
                        },
                    }
                }
            },
        })

        require("telescope").load_extension("ui-select")

        local builtin = require('telescope.builtin')

        vim.keymap.set("n", "<leader>f<leader>", builtin.builtin, {})
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
        vim.keymap.set("n", "<leader>f/", builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set("n", "<leader>fm", builtin.marks, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fp",
            "<cmd>lua require('telescope').extensions.project.project{ display_type = 'full' }<CR>", {})
    end,
}
