vim.g.mapleader = " "

vim.keybinds = {
	gmap = vim.api.nvim_set_keymap,
	bmap = vim.api.nvim_buf_set_keymap,
	dgmap = vim.api.nvim_del_keymap,
	dbmap = vim.api.nvim_buf_del_keymap,
	opts = {noremap = true, silent = true}
}

-- colorscheme
vim.keybinds.gmap("n", "<F3>", 	"<cmd> PreviousColorScheme <CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<F4>",  "<cmd> NextColorScheme <CR>", vim.keybinds.opts)

function Run()
	vim.cmd("w!")
	if(vim.bo.filetype=="cpp") then
		vim.cmd("!g++ -g3 -std=c++2a -Wall % -o %<")
		vim.cmd("!./%<")
	elseif(vim.bo.filetype=="c") then
		vim.cmd("!gcc -g3 -std=c2x -Wall % -o %<")
		vim.cmd("!./%<")
	elseif(vim.bo.filetype=="python")then
		vim.cmd("!python -u %")
	elseif (vim.bo.filetype=="java") then
		vim.cmd("!java %")
	elseif (vim.bo.filetype=="make") then
		vim.cmd("!make clean&&make&&./%<")
	elseif (vim.bo.filetype=="txt") then
		vim.cmd("!cmake ..")
	elseif (vim.bo.filetype=="sh") then
		vim.cmd("!bash %")
	end
end

-- 基础按键
vim.keybinds.gmap("n", "<C-u>", "10k", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-d>", "10j", vim.keybinds.opts)

vim.keybinds.gmap("n", "<A-up>", 	"<cmd> res+5				<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<A-down>", 	"<cmd> res-5				<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<A-left>", 	"<cmd> vertical resize-5	<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<A-right>", "<cmd> vertical resize+5	<CR>", vim.keybinds.opts)

-- 取消find
vim.keybinds.gmap("n", "<CR><CR>" , "<cmd>noh<CR>",vim.keybinds.opts)

-- 运行代码
vim.keybinds.gmap("n","<leader>n" ,"<cmd>lua Run() <CR>", vim.keybinds.opts)

-- 调试代码
vim.keybinds.gmap("n", "<F9>","<cmd>lua require'dap'.toggle_breakpoint()<CR>" ,vim.keybinds.opts)
vim.keybinds.gmap("n", "<F5>","<cmd>lua require'dap'.continue() 		<CR>" ,vim.keybinds.opts)
vim.keybinds.gmap("n", "<F10>","<cmd>lua require'dap'.step_over() 		<CR>" ,vim.keybinds.opts)
vim.keybinds.gmap("n", "<F12>","<cmd>lua require'dap'.step_into() 		<CR>" ,vim.keybinds.opts)

-- 代码格式化
vim.keybinds.gmap("n","<C-k>" ,":w!<CR><cmd>!clang-format -i % <CR>", vim.keybinds.opts)

-- 代码注释
vim.keybinds.gmap("n", "<leader>\\", "gcc", {})
vim.keybinds.gmap("v", "<leader>\\", "gc", {})

-- 代码折叠
vim.keybinds.gmap("n", "<leader>[", "zc", {});
vim.keybinds.gmap("v", "<leader>]", "zo", {});

-- bufferline
vim.keybinds.gmap("","b1", "<Cmd>BufferLineGoToBuffer 1 <CR>", vim.keybinds.opts)
vim.keybinds.gmap("","b2", "<Cmd>BufferLineGoToBuffer 2 <CR>", vim.keybinds.opts)
vim.keybinds.gmap("","b3", "<Cmd>BufferLineGoToBuffer 3 <CR>", vim.keybinds.opts)
vim.keybinds.gmap("","b4", "<Cmd>BufferLineGoToBuffer 4 <CR>", vim.keybinds.opts)
vim.keybinds.gmap("","b5", "<Cmd>BufferLineGoToBuffer 5 <CR>", vim.keybinds.opts)
vim.keybinds.gmap("","b6", "<Cmd>BufferLineGoToBuffer 6 <CR>", vim.keybinds.opts)
vim.keybinds.gmap("","b7", "<Cmd>BufferLineGoToBuffer 7 <CR>", vim.keybinds.opts)
vim.keybinds.gmap("","b8", "<Cmd>BufferLineGoToBuffer 8 <CR>", vim.keybinds.opts)
vim.keybinds.gmap("","b9", "<Cmd>BufferLineGoToBuffer 9 <CR>", vim.keybinds.opts)
vim.keybinds.gmap("","b$", "<Cmd>BufferLineGoToBuffer -1<CR>", vim.keybinds.opts)
vim.keybinds.gmap("","bp", "<Cmd>BufferLineCyclePrev<CR>", vim.keybinds.opts)
vim.keybinds.gmap("","bn", "<Cmd>BufferLineCycleNext<CR>", vim.keybinds.opts)

-- lsp设置
-- 跳转到定义（代替内置 LSP 的窗口，telescope 插件让跳转定义更方便）
vim.keybinds.gmap("n", "gd", "<cmd>Telescope lsp_definitions <CR>", vim.keybinds.opts)
-- 跳转到实现
vim.keybinds.gmap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.keybinds.opts)
-- 列出光标下所有引用（代替内置 LSP 的窗口，telescope 插件让查看引用更方便）
vim.keybinds.gmap("n", "gr", "<cmd>Telescope lsp_references <CR>", vim.keybinds.opts)
-- 工作区诊断（代替内置 LSP 的窗口，telescope 插件让工作区诊断更方便）
vim.keybinds.gmap("n", "go", "<cmd>Telescope diagnostics <CR>", vim.keybinds.opts)
-- 显示代码可用操作（代替内置 LSP 的窗口，telescope 插件让代码行为更方便）
vim.keybinds.gmap("n", "<leader>ca", "<cmd>Telescope lsp_code_actions <CR>", vim.keybinds.opts)
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

-- 查找文件
vim.keybinds.gmap("n", "<leader>ff", "<cmd>Telescope find_files <CR>", vim.keybinds.opts)
-- 查找文字
vim.keybinds.gmap("n", "<leader>fg", "<cmd>Telescope live_grep <CR>", vim.keybinds.opts)
-- 查找帮助文档
vim.keybinds.gmap("n", "<leader>fh", "<cmd>Telescope help_tags <CR>", vim.keybinds.opts)
-- 查找最近打开的文件
vim.keybinds.gmap("n", "<leader>fo", "<cmd>Telescope oldfiles <CR>", vim.keybinds.opts)
-- 查找 marks 标记
vim.keybinds.gmap("n", "<leader>fm", "<cmd>Telescope marks <CR>", vim.keybinds.opts)
-- 文件浏览器
vim.keybinds.gmap("n", "<leader>fb", "<cmd>Telescope file_browser<CR>", vim.keybinds.opts)
-- packer
vim.keybinds.gmap("n", "<leader>p", "<cmd>Telescope packer<CR>", vim.keybinds.opts)
-- 工作区
vim.keybinds.gmap("n", "<leader>fp", "<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<CR>", vim.keybinds.opts)
---: 
-- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--     buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--     buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--     -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--     buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--     buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--     buf_set_keymap('n', 'ge' , '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--     buf_set_keymap('n', 'gpe', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--     buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
--     buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
