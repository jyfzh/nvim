vim.keymap.set("n", "<C-u>", "9k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "9j", { noremap = true, silent = true })

vim.keymap.set("n", "<ESC>", "<cmd>noh<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-g>", function()
    if vim.o.laststatus == 0 then
        vim.o.laststatus = 3
    else
        vim.o.laststatus = 0
    end
end, { noremap = true, silent = true })

vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, { noremap = true })

vim.keymap.set("n", "<F7>", "<cmd>!cmake . -B build && make -C build<cr>", { noremap = true })
vim.keymap.set("n", "<F8>", "<cmd>!make -C build run<cr>", { noremap = true })
