return {
    "ThePrimeagen/refactoring.nvim",
    config = true,
    init = function()
      vim.keymap.set(
          "v",
          "<leader>R",
          require('refactoring').select_refactor)
    end
}
