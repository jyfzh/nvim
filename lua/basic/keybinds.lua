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
