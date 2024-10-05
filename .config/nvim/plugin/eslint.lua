-- Run ESlint on the current file
local function RunESLint()
  local filename = vim.fn.expand "%"
  -- show the diagnostics as virtual text
  vim.diagnostic.config {
    virtual_text = {
      source = true,
      prefix = "ESLint:",
    },
  }
  -- run ESlint asynchronously using the unix format because it's easy to
  -- parse
  vim.fn.jobstart({ "npx", "eslint", filename, "-f", "unix" }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      -- set up a namespace for our diagnostics
      local ns = vim.api.nvim_create_namespace "ESLint"
      vim.diagnostic.reset(ns)
      -- if there was any output, parse it and display the diagnostics
      if data then
        -- unix-style diagnostics are usually formatted as
        -- filename:line:column: message text
        local pattern = ":(%d+):(%d+): (.+)"
        local groups = { "lnum", "col", "message" }
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

-- set up the autocommand to run on opening a file and after saving
local group = vim.api.nvim_create_augroup("JavascriptLsp", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  pattern = { "*.js", "*.jsx", "*.ts" },
  callback = function()
    RunESLint()
  end,
  group = group,
})
