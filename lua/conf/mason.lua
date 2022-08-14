require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup()

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.sumneko_lua.setup{
	capabilities = capabilities,
	-- 比如这里修改成了中文提示信息，具体语言服务器是否支持中文提示还需要查看该语言服务器的配置项
	cmd = {	"lua-language-server", "--locale=zh-CN"},
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
require'lspconfig'.clangd.setup({
	capabilities = capabilities,
	cmd = {"clangd"},
	filetypes = {"c", "cpp", "objc", "objcpp"},
	single_file_support = true,
	init_options = {
		clangdFileStatus = true
	},
})


