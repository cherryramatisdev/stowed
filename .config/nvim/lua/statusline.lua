local M = {}

local function filepath()
  local filename = function()
    local fname = vim.fn.expand "%:t"
    if fname == "" then
      return ""
    end

    return fname .. " "
  end

  local fpath = vim.fn.fnamemodify(vim.fn.expand "%:p:h", ":~:.")
  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %%<%s/%s", fpath, filename())
end

local function lsp()
  local err_count = 0
  local warn_count = 0
  local hint_count = 0
  local info_count = 0

  for _, diagnostic in ipairs(vim.diagnostic.get(vim.api.nvim_get_current_buf())) do
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      err_count = err_count + 1
    elseif diagnostic.severity == vim.diagnostic.severity.WARN then
      warn_count = warn_count + 1
    elseif diagnostic.severity == vim.diagnostic.severity.INFO then
      info_count = info_count + 1
    elseif diagnostic.severity == vim.diagnostic.severity.HINT then
      hint_count = hint_count + 1
    end
  end

  return string.format("E: %s W: %s H: %s I: %s", err_count, warn_count, hint_count, info_count)
end

function M.setup()
  return string.format("%s <%s> %%= [%s]", filepath(), lsp(), vim.bo.filetype)
end

return M
