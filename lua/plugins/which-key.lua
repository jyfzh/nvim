return {
    "folke/which-key.nvim",
    event = "UIEnter",
    config = function()
        require("which-key").setup()
        require("which-key").add({
            { "f" ,  desc = "Telescope" },
            { "c" ,  desc = "code action" },
            { "h" ,  desc = "git" },
            { "r" ,  desc = "rename" },
            { "t" ,  desc = "neotree" },
            { "w" ,  desc = "workspace" },
        }, { prefix = "<leader>" })
    end,
}
