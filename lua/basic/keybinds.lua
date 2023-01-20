vim.keymap.set("n", "<C-u>", "9k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "9j", { noremap = true, silent = true })

vim.keymap.set("n", "<A-up>", "<cmd> res+5				<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-down>", "<cmd> res-5				<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-left>", "<cmd> vertical resize-5	<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-right>", "<cmd> vertical resize+5	<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<CR><CR>", "<cmd>noh<CR>", { noremap = true, silent = true })

-- https://vi.stackexchange.com/questions/10988/toggle-explorer-window
vim.api.nvim_set_var("NetrwIsOpen", false)
vim.keymap.set("n", "<leader>1", function()
    if vim.g.NetrwIsOpen then
        local i = vim.fn.bufnr("$")
        while (i >= 1) do
            if (vim.fn.getbufvar(i, "&filetype") == "netrw") then
                vim.cmd('bwipeout ' .. i)
            end
            i = i - 1
        end
        vim.g.NetrwIsOpen = false
    else
        vim.g.NetrwIsOpen = true
        vim.cmd("Vexplore" .. '')
    end
end, { noremap = true, silent = true, desc = "Toggle explorer tree" })
