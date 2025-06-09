-- 取消换行注释
-- 用o换行不要延续注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    callback = function()
        -- vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
        vim.opt.formatoptions = vim.opt.formatoptions
            - "o" -- O and o, don't continue comments
            + "r" -- But do continue when pressing enter.
    end,
})

-- 重新打开缓冲区恢复光标位置
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.fn.setpos(".", vim.fn.getpos("'\""))
            vim.cmd([[silent! foldopen]])
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = "*",
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(args)
        vim.bo[args.buf].omnifunc = nil
        vim.bo[args.buf].formatexpr = "v:lua.vim.lsp.formatexpr()"

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        vim.keymap.set("i", "<C-space>",
            vim.lsp.completion.get,
            { desc = "trigger autocompletion" })

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange) then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable()
        end

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) and vim.bo.filetype ~= 'bigfile' then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = args.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = args.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(args2)
                    vim.lsp.buf.clear_references()



                    vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = args2.buf }
                    -- vim.cmd 'setl foldexpr <'
                end,
            })
        end

        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
        end)

        vim.keymap.set("n", "[e", function()
            vim.diagnostic.jump({ count = -1, wrap = true, severity = vim.diagnostic.severity.ERROR })
        end, {
            noremap = true,
            silent = true,
            buffer = args.buf,
            desc = "prev error"
        })

        vim.keymap.set("n", "]e", function()
            vim.diagnostic.jump({ count = 1, wrap = true, severity = vim.diagnostic.severity.ERROR })
        end, {
            noremap = true,
            silent = true,
            buffer = args.buf,
            desc = "next error"
        })
    end,
})

