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
local lsp_signature = require("lsp_signature")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'gd', "<cmd>Telescope diagnostics<CR>", opts)

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
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<A-S-f>', "<cmd>lua vim.lsp.buf.format{async=true}<CR>", bufopts)
end

-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")


require 'lspconfig'.sumneko_lua.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace"
			}
		}
	}
}

-- https://clangd.llvm.org/features.html
require 'lspconfig'.clangd.setup({
	handlers = lsp_status.extensions.clangd.setup(),
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--clang-tidy",
		"--fallback-style=LLVM",
		"--function-arg-placeholders=false"
	},
	on_attach = on_attach,
	single_file_support = true,
	init_options = {
		clangdFileStatus = true
	},
})

require'lspconfig'.cmake.setup{}

require 'lspconfig'.jdtls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "jdtls",
		"-configuration", "~/.config/jdtls/config", "-data", "~/.cache/jdtls/workspace" },
	filetypes = { "java" },
	root_dir  =  function ()
		return require "lspconfig".util.root_pattern(
			'.git',
			'build.xml',
			'pom.xml',
			'settings.gradle',
			'settings.gradle.kts',
			'build.gradle',
			'build.gradle.kts'
		)(fname) or vim.fn.getcwd()
	end
}


require 'lspconfig'.pylsp.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = {'W391'},
					maxLineLength = 100
				}
			}
		}
	},
})

require 'lspconfig'.marksman.setup {
	on_attach = on_attach,
	capabilities = capabilities,
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
