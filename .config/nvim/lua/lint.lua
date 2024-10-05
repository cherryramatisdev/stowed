local M = {}

---@param prefix string
---@param cmd table<string>
---@param pattern string
---@param groups table<string>
function M.try_lint(prefix, cmd, pattern, groups)
  local filename = vim.fn.expand "%"

  vim.diagnostic.config {
    virtual_text = {
      source = true,
      prefix = prefix .. ":",
    },
  }

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      local ns = vim.api.nvim_create_namespace(prefix)

      vim.diagnostic.reset(ns)

      if data then
        local ds = {}
        for _, line in ipairs(data) do
          local d = vim.diagnostic.match(line, pattern, groups, {})
          if d then
            table.insert(ds, d)
          end
        end

        vim.diagnostic.set(ns, 0, ds, {})
        vim.diagnostic.show()
      end
    end,
  })
end

return M
