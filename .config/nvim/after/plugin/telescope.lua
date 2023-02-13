local actions = require 'telescope.actions'

local function git_status_with_commit_bind()
	local opts = {}
	opts.attach_mappings = function(prompt_bufnr, map)
		map('i', '<C-c>', function()
			actions.close(prompt_bufnr)
			vim.cmd [[ :TermExec cmd='git commit --no-verify'<cr> ]]
		end)
		return true
	end

	require("telescope.builtin").git_status(opts)
end

vim.keymap.set('n', '<leader>gg', git_status_with_commit_bind, { desc = '[G]it status' })
