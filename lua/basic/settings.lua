-- 设定各种文本的字符编码
vim.o.fenc = "utf-8"
vim.o.fencs = "utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936"
vim.o.encoding = "utf-8"
vim.o.fileencodings = "utf-8,chinese,latin-1,gbk,gb18030,gk2312"

if vim.fn.has('wsl') then
	vim.cmd [[
	let g:clipboard = {
          \   'name': 'myClipboard',
          \   'copy': {
          \      '+': ['/mnt/c/windows/system32/clip.exe'],
          \      '*': ['/mnt/c/windows/system32/clip.exe'],
          \    },
          \   'paste': {
          \      '+': ['/mnt/c/windows/system32/clip.exe'],
          \      '*': ['/mnt/c/windows/system32/clip.exe'],
          \   },
          \   'cache_enabled': 1,
          \ }
]]
else
	vim.o.clipboard = "unnamedplus"
end

vim.o.undofile = true

-- 消息设定
vim.o.shortmess = "tI"
-- 报错信息和行号一体
vim.g.signcolumn = "yes"
-- 不显示mode
vim.o.showmode = false

vim.o.compatible = false
-- 取消搜索高亮
vim.o.hlsearch = true
--智能补全
-- https://zhuanlan.zhihu.com/p/106070272?utm_id=0
vim.opt.completeopt = 'menuone,noselect,noinsert' -- menu ,menuone ,longest ,noinsert,noselect

-- tab
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
-- cmd
vim.o.showcmd = false
vim.o.cmdheight = 1
-- 是否允许缓冲区未保存时就切换
vim.o.hidden = true
-- 是否开启 xterm 兼容的终端 24 位色彩支持
vim.o.termguicolors = true
-- 是否高亮当前文本行
vim.o.cursorline = false
-- 是否开启语法高亮
vim.o.syntax = "enable"
-- 侦测文件类型
vim.o.filetype = "enable"
vim.o.filetype = "plugin"
-- 是否显示绝对行号
-- vim.o.number = true
-- 设定光标上下两侧最少保留的屏幕行数
vim.o.scrolloff = 10
-- 是否支持鼠标操作
vim.o.mouse = "n"
vim.o.selection = "exclusive"
vim.o.selectmode = "mouse,key"
-- 是否开启备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
--不要换行
vim.o.wrap = false
-- 是否特殊显示空格等字符
vim.o.list = false
-- 是否开启自动缩进
vim.o.cindent = true
vim.o.autoindent = true
vim.o.smartindent = true
-- 是否开启高亮搜索
vim.o.hlsearch = true
-- 是否在插入括号时短暂跳转到另一半括号上
vim.o.showmatch = true
-- 是否开启命令行补全
vim.o.wildmenu = true
-- 是否在搜索时忽略大小写
vim.o.ignorecase = true
-- 是否开启在搜索时如果有大写字母，则关闭忽略大小写的选项
vim.o.smartcase = true
-- 是否开启单词拼写检查
vim.o.spell = false;
-- 设定单词拼写检查的语言
vim.o.spelllang = "en_us,cjk"
