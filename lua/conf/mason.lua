-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/nvim-lua/lsp-status.nvim
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

require("mason-lspconfig").setup({
	ensure_installed = { "lua-language-server", "clangd", "pylsp", "marksman" },
	automatic_installation = { "lua-language-server", "clangd", "pylsp", "marksman" },
})

-- Register the progress handler
local lsp_status = require('lsp-status')
lsp_status.register_progress()
local lsp_signature = require("lsp_signature")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

local on_attach = function(client, bufnr)
	lsp_status.on_attach(client)
	lsp_signature.on_attach(client, bufnr) -- Note: add in lsp client on-attach
end

require 'lspconfig'.sumneko_lua.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	log_level = 2,
	-- 再比如我将该服务器的工作域范围改成了当前所在目录的工作区，避免了重复运行多个同样的语言服务器的问题
	root_dir = function()
		return vim.fn.getcwd()
	end,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" }
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			},
			telemetry = {
				enable = true
			}
		}
	}
}

-- https://clangd.llvm.org/features.html
-- require'lspconfig'.clangd.setup({
-- 	capabilities = capabilities,
-- 	cmd = {"clangd"},
-- 	filetypes = {"c", "cpp", "objc", "objcpp"},
-- 	single_file_support = true,
-- 	init_options = {
-- 		clangdFileStatus = true
-- 	},
-- })


require('lspconfig')['pylsp'].setup({
	handlers = lsp_status.extensions.pyls_ms.setup(),
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = function()
		return vim.fn.getcwd()
	end,
	settings = {
		python = {
			workspaceSymbols = {
				enabled = true
			}
		},
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = { 'W391' },
					maxLineLength = 100
				}
			}
		}
	}
})

require 'lspconfig'.marksman.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

capabilities.textDocument.completion.completionItem.snippetSupport = true
require 'lspconfig'.jsonls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
