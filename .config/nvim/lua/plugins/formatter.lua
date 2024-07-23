return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format { async = true }
        end,
        desc = "Format code with conform",
      },
    },
  },
}
