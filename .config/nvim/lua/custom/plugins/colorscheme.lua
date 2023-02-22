return {
  {
    "folke/tokyonight.nvim",
    -- config = function()
    --   vim.cmd.colorscheme "tokyonight-night"
    -- end,
  },
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.cmd.colorscheme "gruvbox-material"
    end,
  },
  {
    "uloco/bluloco.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    -- config = function ()
    --   vim.cmd.colorscheme "bluloco-light"
    -- end
  },
}
