vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt.statusline = "%!v:lua.require('statusline').setup()"
  end,
  group = vim.api.nvim_create_augroup("StatusLine", { clear = true }),
})
