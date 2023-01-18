
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
			},
		})

		local no_really = {
			method = null_ls.methods.DIAGNOSTICS,
			filetypes = { "markdown", "text" },
			generator = {
				fn = function(params)
					local diagnostics = {}
					-- sources have access to a params object
					-- containing info about the current file and editor state
					for i, line in ipairs(params.content) do
						local col, end_col = line:find("really")
						if col and end_col then
							-- null-ls fills in undefined positions
							-- and converts source diagnostics into the required format
							table.insert(diagnostics, {
								row = i,
								col = col,
								end_col = end_col + 1,
								source = "no-really",
								message = "Don't use 'really!'",
								severity = vim.diagnostic.severity.WARN,
							})
						end
					end
					return diagnostics
				end,
			},
		}

		null_ls.register(no_really)

		local helpers = require("null-ls.helpers")

		local markdownlint = {
			method = null_ls.methods.DIAGNOSTICS,
			filetypes = { "markdown" },
			-- null_ls.generator creates an async source
			-- that spawns the command with the given arguments and options
			generator = null_ls.generator({
				command = "markdownlint",
				args = { "--stdin" },
				to_stdin = true,
				from_stderr = true,
				-- choose an output format (raw, json, or line)
				format = "line",
				check_exit_code = function(code, stderr)
					local success = code <= 1

					if not success then
						-- can be noisy for things that run often (e.g. diagnostics), but can
						-- be useful for things that run on demand (e.g. formatting)
						print(stderr)
					end

					return success
				end,
				-- use helpers to parse the output from string matchers,
				-- or parse it manually with a function
				on_output = helpers.diagnostics.from_patterns({
					{
						pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
						groups = { "row", "col", "message" },
					},
					{
						pattern = [[:(%d+) [%w-/]+ (.*)]],
						groups = { "row", "message" },
					},
				}),
			}),
		}

		null_ls.register(markdownlint)

	end,
}
