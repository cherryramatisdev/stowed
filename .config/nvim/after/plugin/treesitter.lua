MiniDeps.add {
  source = "nvim-treesitter/nvim-treesitter",
  hooks = {
    post_chekcout = function()
      vim.cmd [[ TSUpdate ]]
    end,
  },
}

require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "vimdoc", "vim", "typescript", "tsx", "markdown", "markdown_inline" },
  highlight = { enable = true },
}
