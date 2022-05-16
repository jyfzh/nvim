-- https://clangd.llvm.org/features.html
require'lspconfig'.clangd.setup({
	cmd = {"clangd"},
	filetypes = {"c", "cpp", "objc", "objcpp"},
	single_file_support = true,
	init_options = {
		clangdFileStatus = true
	},
})

