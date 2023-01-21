vim.keymap.set("n", "<C-u>", "9k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "9j", { noremap = true, silent = true })

vim.keymap.set("n", "<A-up>", "<cmd> res+5				<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-down>", "<cmd> res-5				<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-left>", "<cmd> vertical resize-5	<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-right>", "<cmd> vertical resize+5	<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<CR><CR>", "<cmd>noh<CR>", { noremap = true, silent = true })
