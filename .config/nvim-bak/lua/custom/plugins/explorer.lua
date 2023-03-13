return {
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup {
        columns = {
          "icon",
        },
        -- Buffer-local options to use for oil buffers
        buf_options = {
          buflisted = false,
        },
        -- Window-local options to use for oil buffers
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "n",
        },
        -- Restore window options to previous values when leaving an oil buffer
        restore_win_options = true,
        -- Skip the confirmation popup for simple operations
        skip_confirm_for_simple_edits = false,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          -- ["<C-p>"] = "actions.preview",
          ["<Esc>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["g."] = "actions.toggle_hidden",
        },
        -- Set to false to disable all of the above keymaps
        use_default_keymaps = false,
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
      }
    end,
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    tag = "nightly",
    config = function()
      -- examples for your init.lua

      -- disable netrw at the very start of your init.lua (strongly advised)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup()

      vim.keymap.set("n", "<leader>op", "<cmd>NvimTreeToggle<cr>")
      vim.keymap.set("n", "<leader>oP", "<cmd>NvimTreeFindFile<cr>")
    end,
  },
}
