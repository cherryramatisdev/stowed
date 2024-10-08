require("mini.notify").setup {}

MiniDeps.add { source = "tpope/vim-scriptease" }
MiniDeps.add {
  source = "willothy/flatten.nvim",
}
require("flatten").setup {}
