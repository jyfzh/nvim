vim.o.fenc = "utf-8"
vim.o.fencs = "utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936"
vim.o.encoding = "utf-8"
vim.o.fileencodings = "utf-8,chinese,latin-1,gbk,gb18030,gk2312"
vim.g.language = "en_US.utf8"

if vim.fn.has("wsl") == 0 and vim.fn.has("win32") == 1 then
	vim.g.sqlite_clib_path = "C:/Windows/System32/sqlite3.dll"
end

local powershell_options = {
	shell = vim.fn.executable "pwsh" and "pwsh" or "powershell",
	shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
	shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
	shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
	shellquote = "",
	shellxquote = "",
}

if vim.fn.has('win32')==1 and vim.fn.has("linux")==0 then
	for option, value in pairs(powershell_options) do
		vim.opt[option] = value
	end
end

-- 补全高度
vim.o.pumheight = 10

vim.o.updatetime = 100 -- update interval for gitsigns
vim.o.timeoutlen = 300 -- keymap timeout
vim.o.sessionoptions = "buffers,curdir,folds,winsize,winpos"
vim.o.undofile = true
vim.o.shortmess = "filnxtToOFI"
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.compatible = false
vim.o.hlsearch = true
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.showcmd = false
vim.o.cmdheight = 0
vim.o.hidden = true
vim.o.termguicolors = true
vim.o.cursorline = false
vim.o.syntax = "enable"
vim.o.filetype = "plugin"
vim.o.scrolloff = 10
vim.o.mouse = "n"
vim.o.selection = "exclusive"
vim.o.selectmode = "mouse,key"
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.wrap = false
-- 是否特殊显示空格等字符
vim.o.list = false
vim.o.cindent = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.showmatch = true
vim.o.wildmenu = true
-- 是否在搜索时忽略大小写
vim.o.ignorecase = true
vim.o.smartcase = true
