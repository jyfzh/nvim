require'lspconfig'.jdtls.setup{
	cmd = { Execute_path..'jdtls' },
	single_file_support = true,
	init_options = {
		jvm_args = {},
		workspace = "/home/jyf/.cache/jdtls/workspace"
	},
	root_dir = function(fname)
		return require'lspconfig'.util.root_pattern('pom.xml', 'gradle.build', '.git')(fname) or vim.fn.getcwd()
	end
}
