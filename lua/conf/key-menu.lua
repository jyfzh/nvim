-- https://github.com/linty-org/key-menu.nvim
require 'key-menu'.set('n', 'h', { desc = 'Git' })
require 'key-menu'.set('n', '<leader>f', { desc = 'telescope' })
require 'key-menu'.set('n', '<leader>')
require 'key-menu'.set('n', '<leader>w', { desc = "lsp_workspace" })
require 'key-menu'.set('n', '<leader>r', { desc = "lsp_rename" })
require 'key-menu'.set('n', '<leader>c', { desc = "lsp_action" })
require 'key-menu'.set('n', '<leader>D', { desc = "lsp_type_definitions" })
require 'key-menu'.set('n', '<leader><leader>', { desc = "hop" })
