function IsNotLargeFile()
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
	if ok and stats and stats.size > max_filesize then
		vim.wo.foldexpr = "0"
		return false
	else
		vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
		return true
	end
end

function Switch_source_header_splitcmd(bufnr, splitcmd)
            bufnr = require("lspconfig").util.validate_bufnr(bufnr)
            local clangd_client = require("lspconfig").util.get_active_client_by_name(bufnr, "clangd")
            local params = { uri = vim.uri_from_bufnr(bufnr) }
            if clangd_client then
                clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
                    if err then
                        error(tostring(err))
                    end
                    if not result then
                        print("Corresponding file can’t be determined")
                        return
                    end
                    vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
                end, bufnr)
            else
                print(
                    "textDocument/switchSourceHeader is not supported by the clangd server active on the current buffer"
                )
            end
        end
