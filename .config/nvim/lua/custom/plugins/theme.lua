return {
  {
    'RRethy/base16-nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'base16-tomorrow-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
