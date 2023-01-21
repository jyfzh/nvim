if vim.g.neovide then
  -- neovide specific settings
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
  vim.g.neovide_transparency = 0.75
  vim.opt.guifont = [[JetBrainsMono NF:h14]]
end

if vim.fn.has("wsl") == 0 and vim.fn.has("win32") == 1 then
    vim.g.sqlite_clib_path = "C:/Windows/System32/sqlite3.dll"
    vim.opt.runtimepath:append("~/scoop/apps/miktex/current/texmfs/install/miktex/bin/x64")
end

vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "utf-8,gb18030,gbk,gb2312,utf-16,cp936,usc-bom,euc-jp"
vim.o.langmenu = "en_US.UTF-8"
vim.o.lazyredraw = true
vim.o.spellcheck = true
vim.g.netrw_sort_by = 'time'
vim.g.netrw_sort_direction = 'reverse'
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25
vim.g.netrw_keepdir = 0
vim.g.mapleader = " "
vim.o.timeout = true
vim.o.updatetime = 100 -- update interval for gitsigns
vim.o.timeoutlen = 500 -- keymap timeout
vim.o.sessionoptions = "buffers,curdir,folds,winsize,winpos"
vim.o.undofile = true
vim.o.shortmess = "filnxtToOF"
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.ruler = false
vim.o.compatible = false
vim.o.hlsearch = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.showcmd = false
vim.o.cmdheight = 0
vim.go.laststatus = 0
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.pumheight = 15
vim.o.hidden = true
vim.o.termguicolors = true
vim.o.cursorline = false
vim.o.syntax = "enable"
vim.o.filetype = "plugin"
vim.o.scrolloff = 5
vim.o.mouse = "n"
vim.o.selection = "exclusive"
vim.o.selectmode = "mouse,key"
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.wrap = false
vim.o.viewoptions = "cursor,folds,slash,unix"
-- 是否特殊显示空格等字符
vim.o.list = false
vim.o.listchars = "tab:> ,trail:·"
vim.o.cindent = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.showmatch = true
vim.o.wildmenu = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 99

vim.cmd("language en_US.utf8")
