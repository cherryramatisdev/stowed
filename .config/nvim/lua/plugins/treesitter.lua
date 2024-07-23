return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "stevearc/dressing.nvim",
      opts = {
        input = {
          enabled = false,
        },
        select = {
          enabled = true,
          backend = { "telescope", "builtin" },
          trim_prompt = true,
          telescope = require("telescope.themes").get_ivy { ... },
          -- Options for built-in selector
          builtin = {
            -- Display numbers for options and set up keymaps
            show_numbers = true,
            -- These are passed to nvim_open_win
            border = "rounded",
            -- 'editor' and 'win' will default to being centered
            relative = "editor",

            buf_options = {},
            win_options = {
              cursorline = true,
              cursorlineopt = "both",
            },

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- the min_ and max_ options can be a list of mixed types.
            -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.9,
            min_height = { 10, 0.2 },

            -- Set to `false` to disable
            mappings = {
              ["<Esc>"] = "Close",
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
            },
          },

          -- Used to override format_item. See :help dressing-format
          format_item_override = {},

          -- see :help dressing_get_config
          get_config = nil,
        },
      },
    },
  },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "luadoc", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
      auto_install = true,
      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}
