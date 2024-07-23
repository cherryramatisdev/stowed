---@diagnostic disable: undefined-global
return {
	'tjdevries/express_line.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local generator = function()
			local function diagnostic_count(bufnr)
				local errors = vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
				local warnings = vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
				local hints = vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })

				return string.format("[E: %s | W: %s | H: %s]", #errors, #warnings, #hints)
			end

			local segments = {}

			local extensions = require('el.extensions')
			local subscribe = require('el.subscribe')

			table.insert(segments, "%=")

			table.insert(segments,
				subscribe.buf_autocmd(
					"el_git_branch",
					"BufEnter",
					function(window, buffer)
						local branch = extensions.git_branch(window, buffer)
						if branch then
							return "[" .. branch .. "]"
						end
					end
				))

			table.insert(segments, " ")
			table.insert(segments, "%y")
			table.insert(segments, " ")
			table.insert(segments,
				subscribe.buf_autocmd(
					"el_diag_count",
					"DiagnosticChanged",
					function(_, buffer)
						return diagnostic_count(buffer.bufnr)
					end
				))
			table.insert(segments, "%=")

			return segments
		end

		-- And then when you're all done, just call
		require('el').setup { generator = generator }
	end
}
