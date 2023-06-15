-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-project.nvim

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-smart-history.nvim", dependencies = "kkharji/sqlite.lua" },
        { "nvim-telescope/telescope-project.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" }
    },
    keys = {
        "<leader>ff",
        "<leader>f<leader>",
        "<leader>fk",
        "<leader>f/",
        "<leader>ff",
        "<leader>fg",
        "<leader>fh",
        "<leader>fo",
        "<leader>fm",
        "<leader>fb",
        "<leader>fp",
        "<leader>fe",
    },
    init = function()
        if vim.fn.has("wsl") == 0 and vim.fn.has("win32") == 1 then
            vim.g.sqlite_clib_path = "C:/Windows/System32/sqlite3.dll"
        end
    end,
    config = function()
        require("telescope").setup({
            defaults = {
                border = false,
                winblend = 0,
                dynamic_preview_title = true,
                path_display = { "truncate" },
                layout_strategy = "bottom_pane",
                layout_config = {
                    preview_cutoff = 1,
                    bottom_pane = {
                        height = 0.9,
                        prompt_position = "bottom",
                    },
                    center = {
                        width = 0.9,
                        height = 0.4,
                    },
                    cursor = {
                        width = 0.8,
                        height = 0.9,
                    },
                    vertical = {
                        width = 0.9,
                        height = 0.9,
                    },
                    horizontal = {
                        width = 0.9,
                        height = 0.9,
                    },
                },
                history = {
                    path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
                    limit = 100,
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                sorting_strategy = "descending",
                file_ignore_patterns = {
                    -- "^.git",
                },
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                mappings = {
                    i = {
                        ["<C-f>"] = require("telescope.actions").preview_scrolling_down,
                        ["<C-b>"] = require("telescope.actions").preview_scrolling_up,
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
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
                    prompt_title = "   Find File",
                    hidden = true,
                    find_command = { "fd", "--type", "f", "--color", "never", "-E", ".git" },
                },
                lsp_definitions = {
                    prompt_title = "   Find Definition",
                    include_declaration = false,
                    include_current_line = false,
                    show_line = false,
                },
                lsp_references = {
                    prompt_title = "   LSP References",
                    include_declaration = false,
                    include_current_line = false,
                    show_line = false,
                },
                keymaps = {
                    prompt_title = "   Keymaps",
                },
                current_buffer_fuzzy_find = {
                    prompt_title = " ﬘  Current Buffer",
                },
                live_grep = {
                    prompt_title = "   Live Grep",
                },
                help_tags = {
                    prompt_title = "  Help Tags",
                },
                oldfiles = {
                    prompt_title = "   Old Files",
                },
                marks = {
                    prompt_title = "  Marks",
                },
                buffers = {
                    prompt_title = " ﬘ Buffers",
                    theme = "dropdown",
                },
                diagnostics = {
                    prompt_title = "  diagnostics",
                },
            },
            extensions = {
                project = {
                    theme = "dropdown",
                    hidden_files = true,
                    -- order_by = "asc",
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
                            height = 0.5,
                        },
                    }
                }
            },
        })
        require("telescope").load_extension("project")
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("smart_history")
        require("telescope").load_extension("ui-select")

        vim.keymap.set("n", "<leader>f<leader>", "<cmd>Telescope <CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps <CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<CR>",
            { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
        vim.keymap.set("n",
            "<leader>fp",
            "<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<CR>",
            { noremap = true, silent = true, desc = "Telescope project" }
        )
        vim.keymap.set("n",
            "<leader>fe",
            "<cmd>lua require'telescope.builtin'.symbols{'nerd','emoji','gitemoji','julia'} <CR>",
            { noremap = true, silent = true, desc = "Telescope symbols" }
        )
    end,
}
