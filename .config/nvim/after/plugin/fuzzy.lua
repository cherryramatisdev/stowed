MiniDeps.add {
  source = "stevearc/dressing.nvim",
}

MiniDeps.add {
  source = "nvim-telescope/telescope.nvim",
  depends = { "nvim-lua/plenary.nvim" },
}

require("dressing").setup {
  input = {
    -- Set to false to disable the vim.ui.input implementation
    enabled = false,
  },
  select = {
    -- Set to false to disable the vim.ui.select implementation
    enabled = true,

    -- Priority list of preferred vim.select implementations
    backend = { "telescope" },

    -- Trim trailing `:` from prompt
    trim_prompt = true,

    telescope = require("telescope.themes").get_ivy { ... },

    -- Used to override format_item. See :help dressing-format
    format_item_override = {},

    -- see :help dressing_get_config
    get_config = nil,
  },
}

require("telescope").setup {
  defaults = {
    layout_strategy = "bottom_pane",
    layout_config = {
      width = 0.75,
      height = 0.30,
      preview_cutoff = 120,
    },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-l>"] = "to_fuzzy_refine",
        ["<esc>"] = "close",
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_ivy(),
    },
  },
}

local builtin = require "telescope.builtin"

vim.keymap.set("n", "<c-f>", builtin.find_files)
vim.keymap.set("n", "<c-s>", builtin.live_grep)
