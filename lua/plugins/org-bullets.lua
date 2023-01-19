-- https://github.com/akinsho/org-bullets.nvim
return {
    "akinsho/org-bullets.nvim",
    config = function()
        require("org-bullets").setup({
            concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
            symbols = {
                headlines = { "", "", "◉", "⊗", "⨴", "○" },

                checkboxes = {
                    half = { "", "OrgTSCheckboxHalfChecked" },
                    done = { "✓", "OrgDone" },
                    todo = { "˟", "OrgTODO" },
                },
            },
        })
    end,
}
