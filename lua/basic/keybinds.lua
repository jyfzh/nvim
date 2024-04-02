vim.keymap.set("n", "<C-u>", "9k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "9j", { noremap = true, silent = true })

vim.keymap.set("n", "<ESC>", "<cmd>noh<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-g>", function ()
    if vim.o.laststatus==0 then
        vim.o.laststatus = 3
    else
        vim.o.laststatus = 0
    end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<F7>", "<cmd>TermExec cmd='make build'<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<F8>", "<cmd>TermExec cmd='make run'<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<F9>", "<cmd>TermExec cmd='make clean'<cr>", { noremap = true, silent = true })
