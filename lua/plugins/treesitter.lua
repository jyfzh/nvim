return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "comment" },
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > vim.g.bigfile_size then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require 'treesitter-context'.setup {
                enable = true,
                max_lines = 5, -- No limit on the number of lines
                trim_scope = 'outer', -- Show context for outer scope
                min_window_height = 0, -- No minimum window height
                mode = 'cursor', -- Show context based on cursor position
            }
            vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true, sp = 'Grey' })
        end
    }
}
