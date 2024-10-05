MiniDeps.add {
  source = "neovim/nvim-lspconfig",
  depends = { "williamboman/mason.nvim" },
}

require("mason").setup {}

require("lspconfig").ts_ls.setup {}
require("lspconfig").lua_ls.setup {}
