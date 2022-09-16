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

vim.o.shortmess = "I"
-- 报错信息和行号一体
vim.g.signcolumn = "yes"
-- 不显示mode
vim.o.showmode = false

vim.o.compatible = false
-- 取消搜索高亮
vim.o.hlsearch = false
--智能补全
-- https://zhuanlan.zhihu.com/p/106070272?utm_id=0
-- menu 弹出一个菜单供大家选择可能的补全项.这个菜单只有当超过一个匹配项时候才会出现
-- menuone 同menu一样,但是即使是只有一个补全项,其依然会展示菜单
-- longest 自动插入开启后,会自动插入最长的补全项.
-- noinsert 不会自动插入任何一个匹配项直到用户自己选择.建议开启,不然在编写代码时候会造成多余操作.
-- noselect 如果不开启,则会在下拉菜单自动选择第一行
vim.opt.completeopt = 'menuone,noselect,noinsert'
-- 不要备份文件（根据自己需要取舍）
vim.o.backup = false
vim.o.writebackup = false

-- 不要生成swap文件，当buffer被丢弃的时候隐藏它
vim.o.bufhidden = "hide"
vim.o.swapfile = false
-- 缩进用空格来表示
vim.o.expandtab = false
-- tab的长度
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
-- 是否在屏幕最后一行显示命令
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
-- 是否显示绝对行号
vim.o.number = false
-- 是否显示相对行号
vim.o.relativenumber = false
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
-- treesitter
-- vim.o.foldenable = true
-- 指定代码折叠的策略是按照缩进进行的
-- vim.o.foldmethod = "indent"
-- 指定代码折叠的最高层级为 100
vim.o.foldlevel = 100
