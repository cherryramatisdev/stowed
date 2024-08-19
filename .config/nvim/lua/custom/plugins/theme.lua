return {
  {
    'chriskempson/base16-vim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'base16-tomorrow-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
