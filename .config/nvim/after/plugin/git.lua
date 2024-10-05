require("mini.notify").setup {}
require("mini.git").setup {}

vim.keymap.set({ "n", "x" }, "<leader>gs", MiniGit.show_at_cursor)

vim.cmd [[
au FileType git,diff setlocal foldmethod=expr foldexpr=v:lua.MiniGit.diff_foldexpr() foldlevel=0
]]
