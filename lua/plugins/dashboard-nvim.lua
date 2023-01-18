-- https://github.com/glepnir/dashboard-nvim
return {
	"glepnir/dashboard-nvim",

	config = function()
		local home = os.getenv("HOMEPATH")
		local db = require("dashboard")
		-- HACK:
		-- macos
		-- db.preview_command = "cat | lolcat -F 0.3"
		-- linux
		-- db.preview_command = "ueberzug"
		--
		-- db.preview_file_path = home .. "/.config/nvim/static/neovim.cat"
		db.custom_header = {
			"",
			"",
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
		}
		db.custom_center = {
			{
				icon = "          ",
				desc = "Recent Projects						  ",
				action = require("telescope").extensions.project.project,
			},
			{
				icon = "      		     ",
				desc = "NeoVim Configuration                  ",
				action = "cd ~/AppData/Local/nvim | :lua require'telescope.builtin'.fd()",
			},
			{
				icon = "	        	     ",
				desc = "Change Colorscheme                    ",
				action = require("telescope.builtin").colorscheme,
			},
			{
				icon = "			   ﬌ ",
				desc = "View Current Folder                   ",
				action = require("telescope.builtin").find_files,
			},
		}
		db.custom_footer = { "hi jyf" }
	end,
}
