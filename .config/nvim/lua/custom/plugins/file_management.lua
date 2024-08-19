return {
  {
    'https://github.com/stevearc/oil.nvim',
    config = true,
    keys = {
      {
        '-',
        function()
          require('oil').open()
        end,
      },
    },
  },
  { 'echasnovski/mini.files', version = '*', config = true, keys = {
    {
      '<leader>e',
      function()
        require('mini.files').open()
      end,
    },
  } },
}
