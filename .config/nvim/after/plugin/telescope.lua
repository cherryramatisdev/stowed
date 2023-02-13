local actions  = require 'telescope.actions'
local Terminal = require('toggleterm.terminal').Terminal

local function git_status_with_commit_bind()
	local opts = {}
	local commit = Terminal:new({ cmd = "git commit -v --no-verify", hidden = true })

	opts.attach_mappings = function(prompt_bufnr, map)
		map('i', '<C-c>', function()
			actions.close(prompt_bufnr)
			commit:open()
		end)
		return true
	end

	require("telescope.builtin").git_status(opts)
end

vim.keymap.set('n', '<leader>gg', git_status_with_commit_bind, { desc = '[G]it status' })
