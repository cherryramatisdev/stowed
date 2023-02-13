return {
  {
    'nvim-neotest/neotest',
    config = function()
      require("neotest").setup({
        quickfix = {
          open = false,
        },
        adapters = {
          require("neotest-jest"),
          require("neotest-rspec"),
        },
      })
    end,
    init = function()
      vim.keymap.set("n", "<leader>tf", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, { desc = "run tests on the whole file" })

      vim.keymap.set("n", "<leader>tt", function()
        require("neotest").run.run()
      end, { desc = "run the nearest test" })

      vim.keymap.set("n", "<leader>ta", function()
        require("neotest").run.attach()
      end, { desc = "attach to nearest test" })

      vim.keymap.set("n", "<leader>tS", function()
        require("neotest").run.stop()
      end, { desc = "force stop nearest test" })

      vim.keymap.set("n", "<leader>ts", function()
        require("neotest").summary.open()
      end, { desc = "open summary for file" })

      vim.keymap.set("n", "<leader>to", function()
        require("neotest").output.open()
      end, { desc = "open test output for nearest test" })
    end
  },
  'olimorris/neotest-rspec',
  'haydenmeade/neotest-jest'
}
