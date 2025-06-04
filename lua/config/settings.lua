vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.laststatus = 0
vim.o.confirm = false
vim.o.cursorline = false
vim.o.formatoptions = "jcroqlnt"
vim.o.number = true
vim.o.relativenumber = true
vim.o.timeout = true
vim.o.updatetime = 100
vim.o.timeoutlen = 500 -- keymap timeout
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.ruler = false
vim.o.hlsearch = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.showcmd = false
vim.o.cmdheight = 0
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.pumheight = 15
vim.o.hidden = true
vim.o.termguicolors = true
vim.o.syntax = "enable"
vim.o.filetype = "plugin"
vim.o.scrolloff = 5
vim.o.mouse = "n"
vim.o.selection = "exclusive"
vim.o.selectmode = "mouse,key"
vim.o.autowrite = false
vim.o.autowriteall = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.wrap = false
vim.o.cindent = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.showmatch = true
vim.o.wildmenu = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.winborder = 'single'
vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

vim.filetype.add {
    pattern = {
        ['.*'] = {
            function(path, buf)
                if vim.bo[buf].filetype ~= 'bigfile' and path and vim.fn.getfsize(path) > vim.g.bigfile_size then
                    return 'bigfile'
                else
                    return nil
                end
            end,
        },
    },
}

vim.diagnostic.config({
        virtual_text = {
            prefix = "",
            spacing = 4,
        },
        float = { severity_sort = true },
        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "",
            }
        },
        underline = true,
        update_in_insert = false,
    })

vim.lsp.enable "lua_ls"
vim.lsp.enable "clangd"
vim.lsp.enable "rust_analyzer"
