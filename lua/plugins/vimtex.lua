return {
	"lervag/vimtex",
	ft = "tex",
	config = function()
		if vim.fn.has("win32") == 1 and vim.fn.has("wsl") == 0 then
			vim.opt.runtimepath:append("~/scoop/apps/miktex/current/texmfs/install/miktex/bin/x64")
		end
	end,
}
