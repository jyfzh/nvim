-- https://github.com/phaazon/hop.nvim
require 'hop'.setup {
	keys = 'etovxqpdygfblzhckisuran'
}

vim.api.nvim_set_keymap("n", "<leader><leader>w", "<cmd>HopWord<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>p", "<cmd>HopPattern<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>c1", "<cmd>HopChar1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>c2", "<cmd>HopChar2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>l", "<cmd>HopLine<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'f',
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
	, {})
vim.api.nvim_set_keymap('', 'F',
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
	, {})
vim.api.nvim_set_keymap('', 't',
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
	, {})
vim.api.nvim_set_keymap('', 'T',
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
	, {})
