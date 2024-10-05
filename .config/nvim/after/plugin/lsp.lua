MiniDeps.add {
  source = "neovim/nvim-lspconfig",
  depends = { "williamboman/mason.nvim" },
}

MiniDeps.add {
  source = "folke/lazydev.nvim",
  ft = "lua",
  depends = { "Bilal2453/luvit-meta" },
}

require("lazydev").setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  },
}

require("mason").setup {}

require("lspconfig").ts_ls.setup {}
require("lspconfig").lua_ls.setup {}
