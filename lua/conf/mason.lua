-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
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
	    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {"lua-language-server","clangd","pylsp"},

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = true,
})
-- completion_customize_lsp_label as used in completion-nvim
-- Optional: customize the kind labels used in identifying the current function.
-- g:completion_customize_lsp_label is a dict mapping from LSP symbol kind 
-- to the string you want to display as a label
-- lsp_status.config { kind_labels = vim.g.completion_customize_lsp_label }

-- Register the progress handler
local lsp_status = require('lsp-status')
lsp_status.register_progress()

require'lspconfig'.sumneko_lua.setup{
	capabilities = lsp_status.capabilities,
	on_attach = lsp_status.on_attach,
	-- 比如这里修改成了中文提示信息，具体语言服务器是否支持中文提示还需要查看该语言服务器的配置项
	cmd = {	"lua-language-server"},
	filetypes = {"lua"},
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
				globals = {"vim"}
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
	capabilities = lsp_status.capabilities,
	-- on_attach = lsp_status.on_attach(),
	root_dir = function()
		return vim.fn.getcwd()
	end,
	settings = {
		python = {
			workspaceSymbols = {
				enabled = true
			}
		},
		pylsp= {
			plugins = {
				pycodestyle = {
					ignore = {'W391'},
					maxLineLength = 100
				}
			}
		}
	}
})
