return {
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ["<C-h>"] = "which_key"
            },
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
    end,
    init = function()
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer]' })

      vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>H', require('telescope.builtin').help_tags, { desc = '[H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>g', require('telescope.builtin').git_status, { desc = '[G]it status' })
      vim.keymap.set('n', '<C-s>', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    end
  },
  { 
    'nvim-telescope/telescope-fzf-native.nvim', 
    build = 'make', 
    cond = vim.fn.executable 'make' == 1
  },
  {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup({
        input = {
          -- Set to false to disable the vim.ui.input implementation
          enabled = true,

          -- Default prompt string
          default_prompt = "Input:",

          -- Can be 'left', 'right', or 'center'
          prompt_align = "left",

          -- When true, <Esc> will close the modal
          insert_only = true,

          -- When true, input will start in insert mode.
          start_in_insert = true,

          -- These are passed to nvim_open_win
          anchor = "SW",
          border = "rounded",
          -- 'editor' and 'win' will default to being centered
          relative = "cursor",

          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          prefer_width = 40,
          width = nil,
          -- min_width and max_width can be a list of mixed types.
          -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },

          buf_options = {},
          win_options = {
            -- Window transparency (0-100)
            winblend = 10,
            -- Disable line wrapping
            wrap = false,
          },

          -- Set to `false` to disable
          mappings = {
            n = {
              ["<Esc>"] = "Close",
              ["<CR>"] = "Confirm",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },
        },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = true,

          -- Priority list of preferred vim.select implementations
          backend = { "telescope", "builtin" },

          -- Trim trailing `:` from prompt
          trim_prompt = true,

          -- Options for built-in selector
          builtin = {
            -- These are passed to nvim_open_win
            anchor = "NW",
            border = "rounded",
            -- 'editor' and 'win' will default to being centered
            relative = "editor",

            buf_options = {},
            win_options = {
              -- Window transparency (0-100)
              winblend = 10,
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
              ["<CR>"] = "Confirm",
            },
          },

          -- Used to override format_item. See :help dressing-format
          format_item_override = {},

          -- see :help dressing_get_config
          get_config = nil,
        },
      })
    end
  },
}
