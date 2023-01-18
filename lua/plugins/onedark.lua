-- https://github.com/navarasu/onedark.nvim
return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
    config = function()
        require("onedark").setup {
            style = 'darker',
            transparent = true,
            term_colors = true, -- Change terminal color as per the selected theme style
            ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
            cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
            -- toggle theme style ---
            toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
            toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between
            -- Change code style ---
            -- Options are italic, bold, underline, none
            -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
            code_style = {
                comments = 'bold',
                keywords = 'none',
                functions = 'none',
                strings = 'none',
                variables = 'none'
            },
            -- Lualine options --
            lualine = {
                transparent = true, -- lualine center bar transparency
            },
            -- Custom Highlights --
            colors = {}, -- Override default colors
            highlights = {
                TSComment                     = { fg = '#868f8b' },
                Normal                      = { bg = 'NONE' },
                NormalFloat                 = { bg = 'NONE' },
                FloatBorder                 = { bg = 'NONE' },
                Floaterm                    = { bg = 'NONE' },
                FloatermBorder              = { bg = 'NONE' },
                TelescopePromptBorder       = { fg = '#a7b8d6' },
                TelescopePreviewBorder      = { fg = '#a7b8d6' },
                TelescopeResultsBorder      = { fg = '#a7b8d6' },
                TelescopeSelection          = { bg = '#5f668a' },
                NeoTreeGitUntracked         = { fg = '#4a69bd' },
                TreesitterContextLineNumber = { fg = '#a0a8b7' },
                PmenuSel                    = { fg = "NONE", bg = "#5f668a" },
                Pmenu                       = { fg = "#C5CDD9", bg = "NONE" },
                DashboardFooter = { fg = "#e2b86b" },
            }, -- Override highlight groups
            diagnostics = {
                darker = false, -- darker colors for diagnostic
                undercurl = true, -- use undercurl instead of underline for diagnostics
                background = false, -- use background color for virtual text
            },
        }

        require("onedark").load()
    end,
}


