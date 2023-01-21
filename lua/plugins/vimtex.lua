return {
	"lervag/vimtex",
	ft = "tex",
    config = function()
        vim.g.vimtex_view_general_viewer = 'SumatraPDF'
        vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
        vim.g.vimtex_compiler_progname = 'nvr'
        vim.g.vimtex_quickfix_mode=0
        vim.g.vimtex_mappings_enabled=0
    end
}
