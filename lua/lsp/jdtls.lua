require("lspconfig").jdtls.setup(
	{
		cmd = { 'jdtls' },
		root_dir = require'lspconfig'.util.root_pattern(".git"),
		init_options = {
			jvm_args = {},
			workspace= "/home/jyf/workspace"
		},
		single_file_support = true,
	}
)
