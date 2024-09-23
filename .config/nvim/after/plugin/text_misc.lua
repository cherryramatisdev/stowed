require('mini.pairs').setup()
require('mini.ai').setup()

require('mini.basics').setup {
  -- Options. Set to `false` to disable.
  options = {
    -- Basic options ('number', 'ignorecase', and many more)
    basic = true,

    -- Extra UI features ('winblend', 'cmdheight=0', ...)
    extra_ui = true,

    -- Presets for window borders ('single', 'double', ...)
    win_borders = 'default',
  },

  -- Mappings. Set to `false` to disable.
  mappings = {
    -- Basic mappings (better 'jk', save with Ctrl+S, ...)
    basic = true,

    -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
    -- Supply empty string to not create these mappings.
    option_toggle_prefix = [[\]],

    -- Window navigation with <C-hjkl>, resize with <C-arrow>
    windows = false,

    -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
    move_with_alt = false,
  },

  -- Autocommands. Set to `false` to disable
  autocommands = {
    -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
    basic = true,

    -- Set 'relativenumber' only in linewise and blockwise Visual mode
    relnum_in_visual_mode = false,
  },

  -- Whether to disable showing non-error feedback
  silent = false,
}

require('mini.bracketed').setup{}

MiniDeps.add({
	source = 'JoosepAlviste/nvim-ts-context-commentstring',
})

require('mini.comment').setup {
  options = {
    custom_commentstring = function()
      return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
    end,
  },
}
