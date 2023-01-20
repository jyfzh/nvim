-- https://github.com/lewis6991/gitsigns.nvim

return {
	"lewis6991/gitsigns.nvim",
	evens = { "BufRead", "BufNewFile" },
	config = function()
		require('gitsigns').setup {
			signs                        = {
				add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
				change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
				delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
				topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
				changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
			},
			signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir                 = {
				interval = 1000,
				follow_files = true
			},
			attach_to_untracked          = true,
			current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts      = {
				virt_text = true,
				virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
			sign_priority                = 6,
			update_debounce              = 100,
			status_formatter             = nil, -- Use default
			max_file_length              = 40000, -- Disable if file is longer than this (in lines)
			preview_config               = {
				-- Options passed to nvim_open_win
				border = 'single',
				style = 'minimal',
				relative = 'cursor',
				row = 0,
				col = 1
			},
			yadm                         = { enable = false },
			on_attach                    = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map('n', ']g', function()
					if vim.wo.diff then return ']g' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, { expr = true })

				map('n', '[g', function()
					if vim.wo.diff then return '[g' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, { expr = true })

				-- Actions
				map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = "stage_hunk" })
				map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = "reset_hunk" })
				map('n', '<leader>hS', gs.stage_buffer, { desc = "stage_buffer" })
				map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "undo stage hunk" })
				map('n', '<leader>hR', gs.reset_buffer, { desc = "reset buffer" })
				map('n', '<leader>hp', gs.preview_hunk, { desc = "preview_hunk" })
				map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "blame_line" })
				map('n', '<leader>htb', gs.toggle_current_line_blame, { desc = "toggle_current_line_blame" })
				map('n', '<leader>hd', gs.diffthis, { desc = "diffthis" })
				map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "diffthis~" })
				map('n', '<leader>htd', gs.toggle_deleted, { desc = "toggle_deleted" })

				-- Text object
				map({ 'o', 'x' }, '<leader>ho', ':<C-U>Gitsigns select_hunk<CR>', { desc = "select_hunk" })
			end
		}
	end
}
