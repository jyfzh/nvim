vim.g.mapleader = " "

vim.keybinds = {
	gmap = vim.api.nvim_set_keymap,
	bmap = vim.api.nvim_buf_set_keymap,
	dgmap = vim.api.nvim_del_keymap,
	dbmap = vim.api.nvim_buf_del_keymap,
	opts = {noremap = true, silent = true}
}

-- 基础按键
vim.keybinds.gmap("n", "<C-u>", "10k", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-d>", "10j", vim.keybinds.opts)

vim.keybinds.gmap("i", "<A-k>", "<up>", vim.keybinds.opts)
vim.keybinds.gmap("i", "<A-j>", "<down>", vim.keybinds.opts)
vim.keybinds.gmap("i", "<A-h>", "<left>", vim.keybinds.opts)
vim.keybinds.gmap("i", "<A-l>", "<right>", vim.keybinds.opts)

vim.keybinds.gmap("n", "<C-up>", "<cmd>res +5<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-down>", "<cmd>res -5<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-left>", "<cmd>vertical resize-5<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-right>", "<cmd>vertical resize+5<CR>", vim.keybinds.opts)

-- lsp设置
-- 跳转到定义（代替内置 LSP 的窗口，telescope 插件让跳转定义更方便）
vim.keybinds.gmap("n", "gd", "<cmd>Telescope lsp_definitions theme=dropdown<CR>", vim.keybinds.opts)
-- 列出光标下所有引用（代替内置 LSP 的窗口，telescope 插件让查看引用更方便）
vim.keybinds.gmap("n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>", vim.keybinds.opts)
-- 工作区诊断（代替内置 LSP 的窗口，telescope 插件让工作区诊断更方便）
vim.keybinds.gmap("n", "go", "<cmd>Telescope diagnostics theme=dropdown<CR>", vim.keybinds.opts)
-- 显示代码可用操作（代替内置 LSP 的窗口，telescope 插件让代码行为更方便）
vim.keybinds.gmap("n", "<leader>ca", "<cmd>Telescope lsp_code_actions theme=dropdown<CR>", vim.keybinds.opts)
-- 变量重命名（代替内置 LSP 的窗口，Lspsaga 让变量重命名更美观）
vim.keybinds.gmap("n", "<F2>", "<cmd>Lspsaga rename<CR>", vim.keybinds.opts)
-- 查看帮助信息（代替内置 LSP 的窗口，Lspsaga 让查看帮助信息更美观）
vim.keybinds.gmap("n", "gh", "<cmd>Lspsaga hover_doc<CR>", vim.keybinds.opts)
-- 跳转到上一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
vim.keybinds.gmap("n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", vim.keybinds.opts)
-- 跳转到下一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
vim.keybinds.gmap("n", "g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", vim.keybinds.opts)
-- 悬浮窗口上翻页，由 Lspsaga 提供
vim.keybinds.gmap("n","<C-p>","<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",vim.keybinds.opts)
-- 悬浮窗口下翻页，由 Lspsaga 提供
vim.keybinds.gmap("n","<C-n>","<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",vim.keybinds.opts)

-- 运行代码
vim.keybinds.gmap("","<F5>" ,":w!<CR><cmd>!g++ -O2 -std=c++2a -Wall % -o %<.exe <CR>", vim.keybinds.opts)
vim.keybinds.gmap("","<F6>" ,"<cmd>!%< <CR>", vim.keybinds.opts)

-- 代码注释
vim.keybinds.gmap("n", "<leader>\\", "gcc", {})
vim.keybinds.gmap("v", "<leader>\\", "gc", {})

-- 代码折叠
vim.keybinds.gmap("n","<leader>[","zc",{});
vim.keybinds.gmap("v","<leader>]","zo",{});
