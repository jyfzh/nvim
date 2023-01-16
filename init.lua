require("basic.settings")
require("basic.keybinds")
require("basic.plugins")
require("basic.autocmd")

require("conf.onedark")

if vim.fn.has("win32") == 1 and vim.fn.has("wsl") == 0 then
	vim.opt.runtimepath:append "~/scoop/apps/miktex/current/texmfs/install/miktex/bin/x64"
end
