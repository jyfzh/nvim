-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("config.settings")
require("config.keybinds")
require("config.autocmd")

require("lazy").setup({
    defaults = { lazy = false },
    spec = {
        { import = "plugins" },
    },
    concurrency = jit.os:find("Windows") and (vim.uv.available_parallelism() * 2) or nil,
    git = {
        log = { "--since=3 days ago" },
        timeout = 120,
        url_format = "https://github.com/%s.git",
    },
    dev = {
        path = "~/projects",
        patterns = {},
    },
    install = {
        missing = true,
        colorscheme = { "default" },
    },
    ui = {
        size = { width = 0.8, height = 0.8 },
        wrap = true,
        border = "single",
        icons = {
            cmd = " ",
            config = "",
            event = " ",
            favorite = " ",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            require = "󰢱 ",
            source = " ",
            start = " ",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
        browser = nil,
        throttle = 20,
        custom_keys = {},
    },
    change_detection = { enabled = false },
    performance = {
        cache = { enabled = true },
        reset_packpath = true,
        rtp = {
            reset = true,
            paths = {},
            disabled_plugins = {
                -- "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                -- "tarPlugin",
                "tohtml",
                "tutor",
                -- "zipPlugin",
            },
        },
    }
})
