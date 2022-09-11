vim.g.mapleader = " "

vim.keybinds = {
    gmap = vim.api.nvim_set_keymap,
    bmap = vim.api.nvim_buf_set_keymap,
    dgmap = vim.api.nvim_del_keymap,
    dbmap = vim.api.nvim_buf_del_keymap,
}

-- vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>2", "<cmd>SymbolsOutline<CR>", { noremap = true, silent = true })
-- 运行代码
vim.api.nvim_set_keymap("n", "<C-A-n>", "<cmd>w!<CR> <cmd>RunFile<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<C-A-m>", "<plug>SnipRun<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<C-A-r>", "<plug>SnipReset<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<C-A-c>", "<plug>SnipClose<CR>", { noremap = true, silent = true })

-- 基础按键
vim.api.nvim_set_keymap("n", "<C-u>", "10k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "10j", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<A-up>", "<cmd> res+5				<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-down>", "<cmd> res-5				<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-left>", "<cmd> vertical resize-5	<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-right>", "<cmd> vertical resize+5	<CR>", { noremap = true, silent = true })

-- 取消find
vim.api.nvim_set_keymap("n", "<CR><CR>", "<cmd>noh<CR>", { noremap = true, silent = true })
-- buffer
vim.api.nvim_set_keymap("n", "bd", "<cmd>bd<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-1>", "<cmd>LualineBuffersJump! 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-2>", "<cmd>LualineBuffersJump! 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-3>", "<cmd>LualineBuffersJump! 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-4>", "<cmd>LualineBuffersJump! 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-5>", "<cmd>LualineBuffersJump! 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-6>", "<cmd>LualineBuffersJump! 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-7>", "<cmd>LualineBuffersJump! 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-8>", "<cmd>LualineBuffersJump! 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-9>", "<cmd>LualineBuffersJump! 9<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-$>", "<cmd>LualineBuffersJump! $<CR>", { noremap = true, silent = true })

-- 调试代码
vim.api.nvim_set_keymap("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require'dap'.continue() 		<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua require'dap'.step_over() 		<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12>", "<cmd>lua require'dap'.step_into() 		<CR>", { noremap = true, silent = true })

-- 代码注释
vim.api.nvim_set_keymap("n", "<leader>\\", "gcc", {})
vim.api.nvim_set_keymap("v", "<leader>\\", "gc", {})

-- vim-floaterm
vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n> <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ft", "<cmd>FloatermNew --autoclose=0 --height=0.9 --width=0.9<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>git",
    "<cmd>FloatermNew --autoclose=1 --height=0.6 --width=0.7 git add . && git commit -m . && git push <CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>FloatermNew --autoclose=0 --height=0.9 --width=0.9 glow % <CR>",
    { noremap = true, silent = true })

-- 查找文件
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files <CR>", { noremap = true, silent = true })
-- 查找文字
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep <CR>", { noremap = true, silent = true })
-- 查找帮助文档
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags <CR>", { noremap = true, silent = true })
-- 查找最近打开的文件
vim.api.nvim_set_keymap("n", "<leader>fo", "<cmd>Telescope oldfiles <CR>", { noremap = true, silent = true })
-- 查找 marks 标记
vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>Telescope marks <CR>", { noremap = true, silent = true })
-- 文件浏览器
vim.api.nvim_set_keymap("n", "<leader>FB", "<cmd>Telescope file_browser<CR>", { noremap = true, silent = true })
-- buffer
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
-- packer
vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>Telescope packer<CR>", { noremap = true, silent = true })
-- 工作区
vim.api.nvim_set_keymap("n", "<leader>fp","<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<CR>", { noremap = true, silent = true })
-- symbols
vim.api.nvim_set_keymap("n", "<leader>fe","<cmd>lua require'telescope.builtin'.symbols{'nerd','emoji','gitemoji','julia'} <CR>", { noremap = true,silent = true })
-- frequency
vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>lua require('telescope').extensions.frecency.frecency()<CR>",{ noremap = true, silent = true })
-- notify
vim.api.nvim_set_keymap("n", "<leader>fn", "<Cmd>Telescope notify theme=dropdown <CR>",{ noremap = true, silent = true })
-- aerial
vim.api.nvim_set_keymap("n", "<leader>fa", "<Cmd>Telescope aerial theme=dropdown <CR>",{ noremap = true, silent = true })
-- cheatsheet
vim.api.nvim_set_keymap("n", "<leader>?", "<cmd>Cheatsheet<CR>", { noremap = true })

-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    require"notify"("venn draw")
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd [[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
    else
        vim.cmd [[setlocal ve=]]
        vim.cmd [[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end

-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR> <cmd>IndentBlanklineDisable<CR>", { noremap = true })
