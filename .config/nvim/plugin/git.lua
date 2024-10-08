local function toggle_lazygit()
  -- Check if the terminal buffer is already open
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
      local ok, term_cmd = pcall(vim.api.nvim_buf_get_var, buf, "term_title")
      if ok and term_cmd:find "lazygit" then
        -- If the terminal is open, switch to it
        vim.api.nvim_set_current_buf(buf)
        vim.cmd "startinsert"
        return
      end
    end
  end

  -- If the terminal is not open, open it
  vim.cmd "terminal lazygit"
end

vim.api.nvim_create_autocmd({ "TermClose" }, {
  pattern = "term://*lazygit",
  callback = function()
    vim.api.nvim_input "<CR>"
  end,
  group = vim.api.nvim_create_augroup("lazygit", { clear = true }),
})

vim.keymap.set("n", "<leader>g", toggle_lazygit, { noremap = true, silent = true })
