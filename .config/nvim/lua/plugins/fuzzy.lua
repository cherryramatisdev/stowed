return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<c-f>", ":Telescope find_files<cr>" },
    { "<c-s>", ":Telescope live_grep<cr>" },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = "close",
          ["<C-h>"] = "which_key",
        },
      },
    },
  },
}
