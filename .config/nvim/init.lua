-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local path_package = vim.fn.stdpath "data" .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
  vim.print "Installing `mini.nvim`"
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd "packadd mini.nvim | helptags ALL"
  vim.print "Installed `mini.nvim`"
end

require("mini.deps").setup { path = { package = path_package } }
