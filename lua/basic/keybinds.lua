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

--ranger
vim.keybinds.gmap("n", "<leader>r",  "<cmd> Ranger <CR>", vim.keybinds.opts)

-- vim-floaterm
vim.keybinds.gmap("t", "<ESC>",  "<C-\\><C-n> <CR>", vim.keybinds.opts)

function Run()
	vim.cmd("w!")
	if(vim.bo.filetype=="cpp") then
		vim.cmd("FloatermNew --autoclose=0 --position=topright g++ -g3 -std=c++2a -Wall %:p -o %:p:h/%:r && %:p:h/%:r && rm -f %:p:h/%:r")
	elseif(vim.bo.filetype=="c") then
		vim.cmd("FloatermNew --autoclose=0 --position=topright gcc -g3 -std=c2x -Wall % -o %< && %< && rm -f %:p:h/%:r")
	elseif(vim.bo.filetype=="python")then
		vim.cmd("FloatermNew --autoclose=0 --position=topright python -u %")
	elseif (vim.bo.filetype=="java") then
		vim.cmd("FloatermNew --autoclose=0 --position=topright java %")
	elseif (vim.bo.filetype=="make") then
		vim.cmd("FloatermNew --autoclose=0 --position=topright make clean&&make&&./%<")
	elseif (vim.bo.filetype=="txt") then
		vim.cmd("FloatermNew --autoclose=0 --position=topright cmake ..")
	elseif (vim.bo.filetype=="sh") then
		vim.cmd("FloatermNew --autoclose=0 --position=topright bash %")
	elseif (vim.bo.filetype=="markdown") then
		vim.cmd("FloatermNew --autoclose=0 --position=center --height=0.9 --width=0.9 glow %:p")
	end
end

-- 运行代码
vim.keybinds.gmap("n","<C-A-n>" ,"<cmd>lua Run() <CR>", vim.keybinds.opts)

-- format
vim.keybinds.gmap("n", "<S-A-f>", "<cmd>lua vim.lsp.buf.formatting() <CR>", vim.keybinds.opts)

-- 基础按键
vim.keybinds.gmap("n", "<C-u>", "10k", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-d>", "10j", vim.keybinds.opts)

vim.keybinds.gmap("n", "<A-up>", 	"<cmd> res+5				<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<A-down>", 	"<cmd> res-5				<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<A-left>", 	"<cmd> vertical resize-5	<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<A-right>", "<cmd> vertical resize+5	<CR>", vim.keybinds.opts)

-- 取消find
vim.keybinds.gmap("n", "<CR><CR>" , "<cmd>noh<CR>",vim.keybinds.opts)


-- buffer
vim.keybinds.gmap("n","bd" ,"<cmd>bd<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n","<A-1>" ,"<cmd>LualineBuffersJump! 1<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n","<A-2>" ,"<cmd>LualineBuffersJump! 2<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n","<A-3>" ,"<cmd>LualineBuffersJump! 3<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n","<A-4>" ,"<cmd>LualineBuffersJump! 4<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n","<A-5>" ,"<cmd>LualineBuffersJump! 5<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n","<A-6>" ,"<cmd>LualineBuffersJump! 6<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n","<A-7>" ,"<cmd>LualineBuffersJump! 7<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n","<A-8>" ,"<cmd>LualineBuffersJump! 8<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n","<A-9>" ,"<cmd>LualineBuffersJump! 9<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n","<A-$>" ,"<cmd>LualineBuffersJump! $<CR>", vim.keybinds.opts)

-- 调试代码
vim.keybinds.gmap("n", "<F9>","<cmd>lua require'dap'.toggle_breakpoint()<CR>" ,vim.keybinds.opts)
vim.keybinds.gmap("n", "<F5>","<cmd>lua require'dap'.continue() 		<CR>" ,vim.keybinds.opts)
vim.keybinds.gmap("n", "<F10>","<cmd>lua require'dap'.step_over() 		<CR>" ,vim.keybinds.opts)
vim.keybinds.gmap("n", "<F12>","<cmd>lua require'dap'.step_into() 		<CR>" ,vim.keybinds.opts)

-- 代码注释
vim.keybinds.gmap("n", "<leader>\\", "gcc", {})
vim.keybinds.gmap("v", "<leader>\\", "gc", {})

vim.keybinds.gmap("n", "<leader>ft", "<cmd>FloatermNew --autoclose=0 --height=0.9 --width=0.9<CR>", vim.keybinds.opts)
vim.keybinds.gmap("t", "q", "<cmd>FloatermNew --autoclose=0 --height=0.9 --width=0.9<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<leader>git", "<cmd>FloatermNew --autoclose=0 --height=0.9 --width=0.9 git add . && git commit -m . && git push <CR>", vim.keybinds.opts)
-- lsp设置
vim.keybinds.gmap("n", "gf", "<cmd>Lspsaga lsp_finder <CR>", vim.keybinds.opts)
-- 显示代码可用操作（代替内置 LSP 的窗口，Lspsaga 插件让代码行为更方便）
vim.keybinds.gmap("n", "ga", "<cmd>Lspsaga code_action <CR>", vim.keybinds.opts)
-- 变量重命名（代替内置 LSP 的窗口，Lspsaga 让变量重命名更美观）
vim.keybinds.gmap("n", "gn", "<cmd>Lspsaga rename<CR>", vim.keybinds.opts)
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

-- 跳转到定义（代替内置 LSP 的窗口，telescope 插件让跳转定义更方便）
vim.keybinds.gmap("n", "gd", "<cmd>Telescope lsp_definitions <CR>", vim.keybinds.opts)
-- 跳转到实现
-- vim.keybinds.gmap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.keybinds.opts)
-- 列出光标下所有引用（代替内置 LSP 的窗口，telescope 插件让查看引用更方便）
vim.keybinds.gmap("n", "gr", "<cmd>Telescope lsp_references <CR>", vim.keybinds.opts)
-- 工作区诊断（代替内置 LSP 的窗口，telescope 插件让工作区诊断更方便）
vim.keybinds.gmap("n", "go", "<cmd>Telescope diagnostics <CR>", vim.keybinds.opts)
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
vim.keybinds.gmap("n", "<leader>FB", "<cmd>Telescope file_browser<CR>", vim.keybinds.opts)
-- buffer
vim.keybinds.gmap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", vim.keybinds.opts)
-- packer
vim.keybinds.gmap("n", "<leader>p", "<cmd>Telescope packer<CR>", vim.keybinds.opts)
-- 工作区
vim.keybinds.gmap("n", "<leader>fp", "<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<CR>", vim.keybinds.opts)
-- symbols
vim.keybinds.gmap("n", "<leader>fe", "<cmd>lua require'telescope.builtin'.symbols{'nerd','emoji','gitemoji','julia'} <CR>", vim.keybinds.opts)
-- frequency
vim.keybinds.gmap("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", vim.keybinds.opts)
