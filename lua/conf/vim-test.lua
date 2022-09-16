-- https://github.com/vim-test/vim-test

-- strategy neovim,dispatch,basic
vim.cmd([[
let test#strategy = 'neovim'  
let g:test#preserve_screen = 0
let g:test#neovim#start_normal = 1
let g:test#echo_command = 0
let test#neovim#term_position = "belowright 20"

]])
