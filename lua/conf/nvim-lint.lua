require('lint').linters_by_ft = {
	cpp = {'cpplint',}
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

require("lint.cpplint")
