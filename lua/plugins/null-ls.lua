return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"jay-babu/mason-null-ls.nvim",
		"williamboman/mason.nvim",
		"nvim-lua/plenary.nvim",
	},
	evnet = "BufRead",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.eslint,
				null_ls.builtins.completion.spell,
				null_ls.builtins.code_actions.gitsigns,
				null_ls.builtins.diagnostics.cmake_lint,
			},
		})
		require("null-ls.custom")
		require("null-ls.markdownlint")
	end,
}
