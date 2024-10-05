require("mini.notify").setup {}
require("mini.git").setup {}

MiniDeps.add {
  source = "NeogitOrg/neogit",
  depends = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
}

require("neogit").setup {}

vim.keymap.set("n", "<leader>gs", ":Neogit<CR>")

vim.cmd [[
au FileType git,diff setlocal foldmethod=expr foldexpr=v:lua.MiniGit.diff_foldexpr() foldlevel=0
]]
