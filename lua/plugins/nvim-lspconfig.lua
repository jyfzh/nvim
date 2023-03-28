-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- ui https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
-- https://github.com/folke/neodev.nvim

-- To instead override float border setting globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	local border = {
		{ "┌", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "┐", "FloatBorder" },
		{ "│", "FloatBorder" },
		{ "┘", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "└", "FloatBorder" },
		{ "│", "FloatBorder" },
	}
	opts = opts or {}
	opts.border = opts.border or border

	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.diagnostic.config({
	virtual_text = { prefix = "", source = "always" }, -- prefix：'●', '▎', 'x'
	float = { source = "always" },
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"jay-babu/mason-null-ls.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/neodev.nvim",
		"mfussenegger/nvim-jdtls",
		"nvim-telescope/telescope.nvim",
		"stevearc/dressing.nvim",
		"j-hui/fidget.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
    enabled = _G.IsNotLargeFile(),
	config = function()
		local lsp_signature = require("lsp_signature")
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
		capabilities.textDocument.completion.completionItem.preselectSupport = true
		capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
		capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
		capabilities.textDocument.completion.completionItem.deprecatedSupport = true
		capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
		capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		}

		vim.keymap.set(
			"n",
			"gf",
			vim.diagnostic.open_float,
			{ noremap = true, silent = true, desc = "diagnostic open float" }
		)
		vim.keymap.set(
			"n",
			"g[",
			vim.diagnostic.goto_prev,
			{ noremap = true, silent = true, desc = "diagnostic goto prev" }
		)
		vim.keymap.set(
			"n",
			"g]",
			vim.diagnostic.goto_next,
			{ noremap = true, silent = true, desc = "diagnostic goto next" }
		)

		local on_attach = function(client, bufnr)
			vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
			lsp_signature.on_attach(client, bufnr)
			-- Mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions

			if client.name == "clangd" then
				vim.keymap.set(
					"n",
					"<A-o>",
					"<cmd>ClangdSwitchSourceHeader<CR>",
					{ noremap = true, silent = true, buffer = true, desc = "switch source header" }
				)
			end

			vim.keymap.set(
				"n",
				"gd",
				"<cmd>Telescope lsp_definitions<CR>",
				{ noremap = true, silent = true, buffer = true, desc = "goto definition" }
			)
			vim.keymap.set(
				"n",
				"gD",
				"<cmd>Telescope lsp_implementations<CR>",
				{ noremap = true, silent = true, buffer = true, desc = "goto implementation" }
			)
			vim.keymap.set(
				"n",
				"go",
				"<cmd>Telescope diagnostics<CR>",
				{ noremap = true, silent = true, buffer = true, desc = "diagnostics" }
			)
			vim.keymap.set("n", "gp", function()
				local params = vim.lsp.util.make_position_params()
				return vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result)
					if result == nil or vim.tbl_isempty(result) then
						return nil
					end
					vim.lsp.util.preview_location(result[1])
				end)
			end, { noremap = true, silent = true, buffer = bufnr, desc = "preview definition" })

			vim.keymap.set(
				"n",
				"gtd",
				vim.lsp.buf.type_definition,
				{ noremap = true, silent = true, buffer = bufnr, desc = "type definition" }
			)
			vim.keymap.set(
				"n",
				"gr",
				"<cmd>Telescope lsp_references <CR>",
				{ noremap = true, silent = true, buffer = bufnr, desc = "lsp_references" }
			)
			vim.keymap.set(
				"n",
				"gi",
				vim.lsp.buf.implementation,
				{ noremap = true, silent = true, buffer = bufnr, desc = "implementation" }
			)
			vim.keymap.set(
				"n",
				"K",
				vim.lsp.buf.hover,
				{ noremap = true, silent = true, buffer = bufnr, desc = "hover doc" }
			)
			vim.keymap.set(
				"n",
				"<C-k>",
				vim.lsp.buf.signature_help,
				{ noremap = true, silent = true, buffer = bufnr, desc = "signature_help" }
			)
			vim.keymap.set(
				"n",
				"<leader>rn",
				vim.lsp.buf.rename,
				{ noremap = true, silent = true, buffer = bufnr, desc = "rename" }
			)
			vim.keymap.set(
				"n",
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ noremap = true, silent = true, buffer = bufnr, desc = "code action" }
			)
			vim.keymap.set(
				"n",
				"<A-S-F>",
				"<cmd>lua vim.lsp.buf.format { async = true }<CR>",
				{ noremap = true, silent = true, buffer = bufnr, desc = "format" }
			)
			vim.keymap.set(
				"n",
				"<leader>wa",
				vim.lsp.buf.add_workspace_folder,
				{ noremap = true, silent = true, buffer = bufnr, desc = "add_workspace_folder" }
			)
			vim.keymap.set(
				"n",
				"<leader>wr",
				vim.lsp.buf.remove_workspace_folder,
				{ noremap = true, silent = true, buffer = bufnr, desc = "remove_workspace_folder" }
			)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, { noremap = true, silent = true, buffer = bufnr, desc = "list workspace fold" })
		end

		require("neodev").setup()

		require("lspconfig").lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "lua-language-server", "--locale=zh-cn" },
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
						autoRequire = false,
					},
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
						disable = {
							"redefined-local",
						},
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
						-- https://github.com/neovim/nvim-lspconfig/issues/1700#issuecomment-1356282825
						checkThirdParty = false,
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})

		local function switch_source_header_splitcmd(bufnr, splitcmd)
			bufnr = require("lspconfig").util.validate_bufnr(bufnr)
			local clangd_client = require("lspconfig").util.get_active_client_by_name(bufnr, "clangd")
			local params = { uri = vim.uri_from_bufnr(bufnr) }
			if clangd_client then
				clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
					if err then
						error(tostring(err))
					end
					if not result then
						print("Corresponding file can’t be determined")
						return
					end
					vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
				end, bufnr)
			else
				print(
					"textDocument/switchSourceHeader is not supported by the clangd server active on the current buffer"
				)
			end
		end

		-- https://clangd.llvm.org/features.html
		capabilities.offsetEncoding = { "utf-16" } -- https://github.com/neovim/neovim/pull/16694
		require("lspconfig").clangd.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = {
				"clangd",
				-- SEE: clangd --help-hidden for possible options
				-- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
				-- to add more `checks`, create  a `.clang-tidy` file in the root directory
				-- SEE: https://clang.llvm.org/extra/clang-tidy
				"--clang-tidy=true",
				"--completion-style=bundled",
				"--cross-file-rename",
				"--fallback-style=LLVM",
				"--function-arg-placeholders=false",
				"--header-insertion=never",
			},
			filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			single_file_support = true,
			init_options = {
				clangdFileStatus = true,
				usePlaceholders = false,
				completeUnimported = true,
				semanticHighlighting = true,
			},
			commands = {
				ClangdSwitchSourceHeader = {
					function()
						switch_source_header_splitcmd(0, "edit")
					end,
					description = "Open source/header in current buffer",
				},
				ClangdSwitchSourceHeaderVSplit = {
					function()
						switch_source_header_splitcmd(0, "vsplit")
					end,
					description = "Open source/header in a new vsplit",
				},
				ClangdSwitchSourceHeaderSplit = {
					function()
						switch_source_header_splitcmd(0, "split")
					end,
					description = "Open source/header in a new split",
				},
			},
		})

		require("lspconfig").cmake.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		require("lspconfig").pylsp.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		require("lspconfig").jsonls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		require("lspconfig").html.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		require("lspconfig").cssls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		require("lspconfig").eslint.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		require("lspconfig").tsserver.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		require("lspconfig").texlab.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
}
