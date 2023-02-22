vim.fn.setenv("GIT_EDITOR", [[nvr -cc tabnew --remote-wait +'set bufhidden=wipe']])
vim.fn.setenv("EDITOR", [[nvr -cc tabnew --remote-wait +'set bufhidden=wipe']])

local function goto_file(bufnr)
  local cursor = vim.api.nvim_win_get_cursor(0)
  require("toggleterm").toggle(0)
  vim.api.nvim_win_set_buf(0, bufnr)
  vim.api.nvim_win_set_cursor(0, cursor)
  vim.api.nvim_buf_del_keymap(0, "n", "gf")
  vim.cmd "norm gf"
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  callback = function(params)
    vim.keymap.set("n", "gf", function()
      goto_file(params.buf)
    end, { buffer = params.buf })
  end,
})
