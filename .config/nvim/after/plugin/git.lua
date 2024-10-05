require("mini.notify").setup {}
require("mini.git").setup {}

MiniDeps.add {
  source = "kdheepak/lazygit.nvim",
  depends = {
    "nvim-lua/plenary.nvim",
  },
}

vim.keymap.set("n", "<leader>g", ":LazyGit<cr>", { desc = "Open LazyGit" })

vim.cmd [[
au FileType git,diff setlocal foldmethod=expr foldexpr=v:lua.MiniGit.diff_foldexpr() foldlevel=0
]]
