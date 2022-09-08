local Hydra = require('hydra')
local venn= [[
 Arrow^^^^^^   Select region with <C-v> 
 ^ ^ _K_ ^ ^   _f_: surround it with box
 _H_ ^ ^ _L_
 ^ ^ _J_ ^ ^                      _<Esc>_
]]

Hydra({
   name = 'Draw Diagram',
   hint = venn,
   config = {
      color = 'pink',
      invoke_on_body = true,
      hint = {
         border = 'rounded'
      },
      on_enter = function()
         vim.o.virtualedit = 'all'
      end,
   },
   mode = 'n',
   body = '<leader>v',
   heads = {
      { 'H', '<C-v>h:VBox<CR>' },
      { 'J', '<C-v>j:VBox<CR>' },
      { 'K', '<C-v>k:VBox<CR>' },
      { 'L', '<C-v>l:VBox<CR>' },
      { 'f', ':VBox<CR>', { mode = 'v' }},
      { '<Esc>', nil, { exit = true } },
   }
})

local cmd = require('hydra.keymap-util').cmd

local telescope= [[
                 _f_: files       _m_: marks
   ██████████    _o_: old files   _g_: live grep
  ████    ████   _p_: projects    _/_: search in file
  █ ▁      ██
  ███      ███   _r_: resume      _u_: undotree
 ██████████████  _h_: vim help    _c_: execute command
████████████████ _k_: keymaps     _;_: commands history 
                 _O_: options     _?_: search history
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]

Hydra({
   name = 'Telescope',
   hint = telescope,
   config = {
      color = 'teal',
      invoke_on_body = true,
      hint = {
         position = 'middle',
         border = 'rounded',
      },
   },
   mode = 'n',
   body = '<Leader>f',
   heads = {
      { 'f', cmd 'Telescope find_files' },
      { 'g', cmd 'Telescope live_grep' },
      { 'o', cmd 'Telescope oldfiles', { desc = 'recently opened files' } },
      { 'h', cmd 'Telescope help_tags', { desc = 'vim help' } },
      { 'm', cmd 'MarksListBuf', { desc = 'marks' } },
      { 'k', cmd 'Telescope keymaps' },
      { 'O', cmd 'Telescope vim_options' },
      { 'r', cmd 'Telescope resume' },
      { 'p', cmd 'Telescope projects', { desc = 'projects' } },
      { '/', cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
      { '?', cmd 'Telescope search_history',  { desc = 'search history' } },
      { ';', cmd 'Telescope command_history', { desc = 'command-line history' } },
      { 'c', cmd 'Telescope commands', { desc = 'execute command' } },
      { 'u', cmd 'silent! %foldopen! | UndotreeToggle', { desc = 'undotree' }},
      { '<Enter>', cmd 'Telescope', { exit = true, desc = 'list all pickers' } },
      { '<Esc>', nil, { exit = true, nowait = true } },
   }
})
