return {
	"skywind3000/asyncrun.vim",
	dependencies = "skywind3000/asynctasks.vim",
	keys = {
		{ "<F7>", "<cmd>AsyncTask build<CR>", "n", { noremap = true, silent = true } },
		{ "<F8>", "<cmd>AsyncTask run<CR>", "n", { noremap = true, silent = true } },
	},
	config = function()
		vim.g.asyncrun_open = 6
	end,
}
