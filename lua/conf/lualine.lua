-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { '' },
            winbar = { '' },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = { 'branch', 'diff' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = { 'progress' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = { 'filetype' },
        lualine_z = {}
    },
    tabline = {
        lualine_a = { 'require("hydra.statusline").get_name()' },
        lualine_b = {},
        lualine_c = { 'buffers' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = {},
        lualine_z = {}
    },
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { require("nvim-navic").get_location, cond = require("nvim-navic").is_availabl },
        lualine_x = { 'require"lsp-status".status():sub(1,60)'},
        lualine_y = {},
        lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filetype' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    extensions = { 'quickfix', 'nvim-dap-ui', 'symbols-outline' }
}
