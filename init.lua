-- https://github.com/lewis6991/impatient.nvim
_G.__luacache_config = {
	chunks = {
		enable = true,
		path = vim.fn.stdpath('cache') .. '/luacache_chunks',
	},
	modpaths = {
		enable = true,
		path = vim.fn.stdpath('cache') .. '/luacache_modpaths',
	}
}
require('impatient')

require("basic.settings")
require("basic.keybinds")
require("basic.plugins")
require("basic.autocmd")

require("conf.onedark")

if vim.fn.has("win32") == 1 and vim.fn.has("wsl") == 0 then
	vim.opt.runtimepath:append "~/scoop/apps/miktex/current/texmfs/install/miktex/bin/x64"
end
