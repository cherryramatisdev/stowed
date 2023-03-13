local Terminal = require("toggleterm.terminal").Terminal
local M = {}

function M.run_commit()
  local commit = Terminal:new { cmd = "git commit -v --no-verify", hidden = true }
  commit:open()
end

return M
