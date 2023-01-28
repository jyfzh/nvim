-- https://github.com/akinsho/org-bullets.nvim
return {
    "akinsho/org-bullets.nvim",
    ft = "org",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-orgmode/orgmode",
    },
    config = function()
        require("org-bullets").setup({
            -- If false then when the cursor is on a line underlying characters are visible
            concealcursor = true,
            symbols = {
                headlines = { "◉", "○", "✸", "✿", "✤" },
                checkboxes = {
                    half = { "", "OrgTSCheckboxHalfChecked" },
                    done = { "✓", "OrgDone" },
                    todo = { "˟", "OrgTODO" },
                },
            },
        })
    end,
}
