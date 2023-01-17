vim.g.mapleader = " "

vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>gg", "<cmd>Neotree git_status<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>t", "<cmd>NeoTreeRevealToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>s", "<cmd>SymbolsOutline<CR>", { noremap = true, silent = true })

-- todo-comments
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
vim.keymap.set('n', '<leader>ft', "<cmd>TodoTelescope<CR>", { noremap = true })

-- venn
vim.keymap.set('n', '<leader>v', ":lua Toggle_venn()<CR> <cmd>IndentBlanklineDisable<CR>", { noremap = true })

-- run code
vim.keymap.set("n", "<F7>", "<cmd>AsyncTask build<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<F8>", "<cmd>AsyncTask run<CR>", { noremap = true, silent = true })

-- debug
vim.keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue() 		<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<F10>", "<cmd>lua require'dap'.step_over() 		<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<F12>", "<cmd>lua require'dap'.step_into() 		<CR>", { noremap = true, silent = true })

-- basic
vim.keymap.set("n", "<C-u>", "9k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "9j", { noremap = true, silent = true })

vim.keymap.set("n", "<A-up>", "<cmd> res+5				<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-down>", "<cmd> res-5				<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-left>", "<cmd> vertical resize-5	<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-right>", "<cmd> vertical resize+5	<CR>", { noremap = true, silent = true })

-- no highlight
vim.keymap.set("n", "<CR><CR>", "<cmd>noh<CR>", { noremap = true, silent = true })

-- buffer
vim.keymap.set("n", "<A-1>", "<cmd>LualineBuffersJump! 1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-2>", "<cmd>LualineBuffersJump! 2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-3>", "<cmd>LualineBuffersJump! 3<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-4>", "<cmd>LualineBuffersJump! 4<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-5>", "<cmd>LualineBuffersJump! 5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-6>", "<cmd>LualineBuffersJump! 6<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-7>", "<cmd>LualineBuffersJump! 7<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-8>", "<cmd>LualineBuffersJump! 8<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-9>", "<cmd>LualineBuffersJump! 9<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-$>", "<cmd>LualineBuffersJump! $<CR>", { noremap = true, silent = true })

-- find key
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps <CR>",
	{ noremap = true, silent = true })
-- current_buf_fuzzy_find
vim.keymap.set("n", "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<CR>",
	{ noremap = true, silent = true })
-- 查找文件
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>",
	{ noremap = true, silent = true })
-- 查找文字
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",
	{ noremap = true, silent = true })
-- 查找帮助文档
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",
	{ noremap = true, silent = true })
-- 查找最近打开的文件
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>",
	{ noremap = true, silent = true })
-- 查找 marks 标记
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>", { noremap = true, silent = true })
-- buffer
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>",
	{ noremap = true, silent = true })
-- 工作区
vim.keymap.set("n", "<leader>fp",
	"<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<CR>",
	{ noremap = true, silent = true })
-- symbols
vim.keymap.set("n", "<leader>fe",
	"<cmd>lua require'telescope.builtin'.symbols{'nerd','emoji','gitemoji','julia'} <CR>",
	{ noremap = true, silent = true })
-- asynctasks
vim.keymap.set("n", "<leader>fa", "<Cmd>Telescope asynctasks all theme=dropdown <CR>",
	{ noremap = true, silent = true })
