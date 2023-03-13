local actions = require "telescope.actions"
local run_commit = require('utils.git').run_commit

local function git_status_with_commit_bind()
  local opts = {}

  opts.attach_mappings = function(prompt_bufnr, map)
    map("i", "<C-c>", function()
      actions.close(prompt_bufnr)
      run_commit()
    end)
    return true
  end

  require("telescope.builtin").git_status(opts)
end

local function find_files_stowed()
  local opts = {
    prompt = "~ Dotfiles ~",
    cwd = vim.fn.expand "~/Repos/stowed",
    hidden = true,
  }
  require("telescope.builtin").find_files(opts)
end

vim.keymap.set("n", "<leader>gg", git_status_with_commit_bind, { desc = "Git status" })
vim.keymap.set("n", "<leader>c", find_files_stowed, { desc = 'Check dotfiles' })
