-- 退出光标复原
vim.api.nvim_create_autocmd({ "VimLeave" }, { command = "set guicursor=a:ver25-blinkon0" })

--行号切换
vim.api.nvim_create_autocmd({ "InsertEnter" }, { command = "lua vim.o.relativenumber = false" })
vim.api.nvim_create_autocmd({ "InsertLeave" }, { command = "lua vim.o.relativenumber = true" })

-- neotree
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    -- command = "Neotree show left",
    callback = function()
        local timer = vim.loop.new_timer();
        timer:start(100, 10, vim.schedule_wrap(function()
            local stop_signal = true
            if stop_signal == true and timer:is_closing() == false then
                print('stop timer and close it')
                vim.cmd("Neotree show filesystem reveal left")
                timer:stop()
                timer:close()
            end
        end))

    end
})
