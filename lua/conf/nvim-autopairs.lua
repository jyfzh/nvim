-- https://github.com/windwp/nvim-autopairs
local disable_filetype = { "TelescopePrompt" }
local disable_in_macro = false -- disable when recording or executing a macro
local disable_in_visualblock = false -- disable when insert after visual block mode
local ignored_next_char = [=[[%w%%%'%[%"%.]]=]
local enable_moveright = true
local enable_afterquote = true -- add bracket pairs after quote
local enable_check_bracket_line = true --- check bracket in same line
local enable_bracket_in_quote = true --
local enable_abbr = false -- trigger abbreviation
local break_undo = true -- switch for basic rule break undo sequence
local check_ts = false
local map_cr = true
local map_bs = true -- map the <BS> key
local map_c_h = false -- Map the <C-h> key to delete a pair
local map_c_w = false -- map <c-w> to delete a pair if possible

local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

require("nvim-autopairs").setup({
	check_ts = true,
	ts_config = {
		lua = { 'string' }, -- it will not add a pair on that treesitter node
		javascript = { 'template_string' },
		java = false, -- don't check treesitter on java
	},
	enable_check_bracket_line = false,
	ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
	fast_wrap = {
		map = '<M-e>',
		chars = { '{', '[', '(', '"', "'" },
		pattern = [=[[%'%"%)%>%]%)%}%,]]=],
		end_key = '$',
		keys = 'qwertyuiopzxcvbnmasdfghjkl',
		check_comma = true,
		highlight = 'Search',
		highlight_grey = 'Comment'
	},
})

local ts_conds = require('nvim-autopairs.ts-conds')


-- press % => %% only while inside a comment or string
npairs.add_rules({
	Rule("%", "%", "lua")
		:with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
	Rule("$", "$", "lua")
		:with_pair(ts_conds.is_not_ts_node({ 'function' }))
})
