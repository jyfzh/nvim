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

-- 报错信息和行号一体
vim.opt.signcolumn = "number"
-- cursorhold的间隔时间
vim.g.updatetime=1000
-- 不显示mode
vim.o.showmode = false

vim.o.compatible = false
-- 取消搜索高亮
vim.o.hlsearch = false
--智能补全
vim.o.completeopt = "longest,menu,menuone,noselect"
-- 不要备份文件（根据自己需要取舍）
vim.o.backup = false
vim.o.writebackup = false

-- 不要生成swap文件，当buffer被丢弃的时候隐藏它
vim.o.bufhidden = "hide"
vim.o.swapfile = false

-- 使回格键（backspace）正常处理indent, eol, start等
--vim.o.backspace=2

-- tab的长度
vim.o.tabstop = 4
vim.o.shiftwidth = 4
-- 是否在屏幕最后一行显示命令
vim.o.showcmd = true
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
-- 是否显示绝对行号
vim.o.number = true
-- 是否显示相对行号
vim.o.relativenumber = true
-- 设定光标上下两侧最少保留的屏幕行数
vim.o.scrolloff = 10
-- 是否支持鼠标操作
vim.o.mouse = "n"
vim.o.selection = "exclusive"
vim.o.selectmode = "mouse,key"
-- 是否开启备份文件
vim.o.backup = false
--不要换行
vim.o.wrap = false
-- 是否开启交换文件
vim.o.swapfile = false
-- 是否特殊显示空格等字符
vim.o.list = false
-- 是否开启自动缩进
vim.o.autoindent = true
-- 设定自动缩进的策略为 plugin
vim.o.filetype = "plugin"
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
-- 是否开启代码折叠
vim.o.foldenable = true
-- 指定代码折叠的策略是按照缩进进行的
vim.o.foldmethod = "indent"
-- 指定代码折叠的最高层级为 100
vim.o.foldlevel = 100
