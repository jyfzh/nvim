-- https://github.com/glepnir/dashboard-nvim
return {
	"glepnir/dashboard-nvim",

	config = function()
		local db = require("dashboard")
		db.custom_header = {
			"",
			"",
			"",
			"",
			" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
			" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
			" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
			" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
			" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
			" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
			"",
			"",
		}
		db.custom_center = {
			{
				icon = "         ",
				desc = "Recent Projects						  ",
				action = require("telescope").extensions.project.project,
			},
			{
				icon = "       		    ",
				desc = "NeoVim Configuration                  ",
				action = "cd ~/AppData/Local/nvim | :lua require'telescope.builtin'.fd()",
			},
			{
				icon = "	                    ",
				desc = "Change Colorscheme                    ",
				action = require("telescope.builtin").colorscheme,
			},
			{
				icon = "	                ",
				desc = "Current Folder                   ",
				action = require("telescope.builtin").find_files,
			},
		}
		db.custom_footer = {
			"",
			"I met a superhero, I lost her, I want her back",
			"                                                       -- Lauv",
		}
	end,
}
