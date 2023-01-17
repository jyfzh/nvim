-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- ui https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
-- https://github.com/folke/lua-dev.nvim

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
vim.diagnostic.config(
	{
		virtual_text = { prefix = "", source = "always" }, -- prefix：'●', '▎', 'x'
		float = { source = "always" },
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
	}
)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- LSP settings (for overriding per client)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	vim.lsp.handlers.hover,
	{ border = 'single' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
	vim.lsp.handlers.signature_help,
	{ border = 'single' }
)

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- lua-dev
-- IMPORTANT: make sure to setup lua-dev BEFORE lspconfig
require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
	library = {
		enabled = true, -- when not enabled, lua-dev will not change any settings to the LSP server
		runtime = true, -- runtime path
		types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
		plugins = true, -- installed opt or start plugins in packpath
	},
	setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
	-- for your Neovim config directory, the config.library settings will be used as is
	-- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
	-- for any other directory, config.library.enabled will be set to false
	override = function(root_dir, options) end,
})

-- Register the progress handler
local lsp_status = require('lsp-status')
lsp_status.register_progress()
lsp_status.config({
	indicator_errors = '',
	indicator_warnings = '',
	indicator_info = '',
	indicator_hint = '',
	indicator_ok = '',
	indicator_messages = '',
	indicator_warnings_count = '',
	indicator_errors_count = '',
	indicator_messages_count = '',
	indicator_hint_count = '',
	indicator_info_count = '',
	indicator_ok_count = '',
	current_function = true,
	show_filename = false,
})

local lsp_signature = require("lsp_signature")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

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
		"additionalTextEdits"
	}
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'go', "<cmd>Telescope diagnostics<CR>", opts)

local on_attach = function(client, bufnr)
	vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
	lsp_status.on_attach(client)
	lsp_signature.on_attach(client, bufnr)

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references theme=dropdown<CR>", bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<leader>d', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<A-S-F>', "<cmd>lua vim.lsp.buf.format{async=true}<CR>", bufopts)
end

-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")


require 'lspconfig'.sumneko_lua.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "lua-language-server", "--locale=zh-cn" },
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace"
			},
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				-- library = vim.api.nvim_get_runtime_file("", true),
				library = vim.fn.stdpath('config') .. '/lua',
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		}
	}
}

-- https://clangd.llvm.org/features.html
capabilities.offsetEncoding = { "utf-16" } -- https://github.com/neovim/neovim/pull/16694

require 'lspconfig'.clangd.setup({
	handlers = lsp_status.extensions.clangd.setup(),
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--clang-tidy",
		"--fallback-style=LLVM",
		"--function-arg-placeholders=false"
	},
	single_file_support = true,
	init_options = {
		clangdFileStatus = true
	},
})

require 'lspconfig'.cmake.setup {
	capabilities = capabilities,
	on_attach = on_attach,
}

require 'lspconfig'.pylsp.setup {
	capabilities = capabilities,
	on_attach = on_attach,
}

require 'lspconfig'.jsonls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

require 'lspconfig'.html.setup {
	on_attach    = on_attach,
	capabilities = capabilities
}

require 'lspconfig'.cssls.setup {
	on_attach    = on_attach,
	capabilities = capabilities,
}
require 'lspconfig'.eslint.setup {
	on_attach    = on_attach,
	capabilities = capabilities,
}
require 'lspconfig'.tsserver.setup {
	on_attach    = on_attach,
	capabilities = capabilities,
}

require 'lspconfig'.texlab.setup {
	on_attach    = on_attach,
	capabilities = capabilities,
}
