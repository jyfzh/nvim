-- https://clangd.llvm.org/features.html
require'lspconfig'.clangd.setup({
	cmd = {Execute_path.."clangd"},
	filetypes = {"c", "cpp", "objc", "objcpp"},
	single_file_support = true,
	init_options = {
		clangdFileStatus = true
	},
})
