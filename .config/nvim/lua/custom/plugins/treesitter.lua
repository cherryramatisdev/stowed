return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
          enable = true,
          max_lines = 2,
          min_window_height = 0,
          line_numbers = true,
          multiline_threshold = 20,
          trim_scope = 'outer',
          mode = 'cursor',
          separator = nil,
          zindex = 20,
          on_attach = nil,
        },
        config = function(_, opts)
          require('treesitter-context').setup(opts)
        end,
      },
    },
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
