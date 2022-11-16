-- https://github.com/mfussenegger/nvim-jdtls
-- [dotfile]
-- https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/ftplugin/java.lua
local jdtls = require('jdtls')
local opts = { noremap = true, silent = true }

local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;

jdtls.start_or_attach({
	on_attach = function()
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references theme=dropdown<CR>", opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<A-S-f>', "<cmd>lua vim.lsp.buf.format{async=true}<CR>", opts)

		vim.keymap.set('n', "<A-o>", jdtls.organize_imports, opts)
		vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
		vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
		vim.keymap.set('n', "crv", jdtls.extract_variable, opts)
		vim.keymap.set('v', "crv", [[<ESC><CMD>jdtls.extract_variable(true)<CR>]], opts)
		vim.keymap.set('n', "crc", jdtls.extract_constant, opts)
		vim.keymap.set('v', "crc", [[<ESC><CMD>lua require"jdtls".extract_constant(true)<CR>]], opts)
		vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)

		jdtls.setup_dap({ hotcodereplace = 'auto' })
		jdtls.setup.add_commands()

	end,
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		'java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xms1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-jar',
		-- must absolute path on windows
		'C:/Users/jyf/AppData/Local/nvim-data/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
		'-configuration', 'C:/Users/jyf/AppData/Local/nvim-data/mason/packages/jdtls/config_win',
		'-data', 'C:/Users/jyf/.cache/jdtls/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
	},
	root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = {
		java = {
			configuration = {
				-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
				-- And search for `interface RuntimeOption`
				-- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
				runtimes = {
					{
						name = "JavaSE-11",
						path = "C:/Users/jyf/scoop/apps/openjdk11/current",
					},
					{
						name = "JavaSE-19",
						path = "C:/Users/jyf/scoop/apps/openjdk/current",
					},
				}
			},
			signatureHelp = { enabled = true };
			contentProvider = { preferred = 'fernflower' };
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*"
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
				sources = {
					organizeImports = {
						starThreshold = 9999;
						staticStarThreshold = 9999;
					};
				};
				codeGeneration = {
					toString = {
						template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
					},
					hashCodeEquals = {
						useJava7Objects = true,
					},
					useBlocks = true,
				};
			};
		}
	},
	-- if you want to use additional eclipse.jdt.ls plugins.
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	init_options = {
		extendedClientCapabilities = extendedClientCapabilities;
		bundles = {}
	},
})
