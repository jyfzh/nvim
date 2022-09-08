-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 200,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = { 'branch', 'diff' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
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
        lualine_x = { 'require"lsp-status".status()' },
        lualine_y = {},
        lualine_z = {}
    },
    winbar = {},
    inactive_winbar = {},
    extensions = { 'quickfix', 'nvim-dap-ui', }
}
