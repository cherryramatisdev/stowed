local M = {}

--@param mode string
--@param lhs string
--@param rhs string
--@param filepattern string
--@param event string
function M.map_on_filepattern(mode, lhs, rhs, filepattern, opts)
  opts = opts or {}
  opts.enter_event = opts.enter_event or "BufEnter"
  opts.leave_event = opts.leave_event or "BufLeave"
  vim.api.nvim_create_autocmd({ opts.enter_event }, {
    pattern = filepattern,
    callback = function()
      vim.keymap.set(mode, lhs, rhs)
    end,
  })

  vim.api.nvim_create_autocmd({ opts.leave_event }, {
    pattern = filepattern,
    callback = function()
      vim.keymap.del(mode, lhs)
    end,
  })
end

return M
