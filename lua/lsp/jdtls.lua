require'lspconfig'.jdtls.setup{
	cmd = { 'jdtls' },
	single_file_support = true,
	root_dir = function(fname)
		return require'lspconfig'.util.root_pattern('pom.xml', 'gradle.build', '.git')(fname) or vim.fn.getcwd()
	end
}
