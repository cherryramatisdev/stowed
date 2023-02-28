return {
  "neovim/nvim-lspconfig",

  -- Automatically install LSPs to stdpath for neovim
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jay-babu/mason-null-ls.nvim",
  "jose-elias-alvarez/null-ls.nvim",

  -- Useful status updates for LSP
  "j-hui/fidget.nvim",

  -- Additional lua configuration, makes nvim stuff amazing
  "folke/neodev.nvim",

  -- nice winbar
  -- "utilyre/barbecue.nvim",
  -- "SmiteshP/nvim-navic",
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup {}
      -- Enable inlay hints auto update and set them for all the buffers
      require("rust-tools").inlay_hints.enable()
    end,
  },
}
