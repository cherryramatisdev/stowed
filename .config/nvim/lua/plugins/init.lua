return {
	{
		"williamboman/mason.nvim", opts = {}
	},
	"tpope/vim-sleuth",
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	}
}
