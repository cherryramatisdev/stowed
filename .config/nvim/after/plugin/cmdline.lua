MiniDeps.add {
  source = "VonHeikemen/fine-cmdline.nvim",
  depends = { "MunifTanjim/nui.nvim" },
}

require("fine-cmdline").setup {
  cmdline = {
    enable_keymaps = true,
    smart_history = true,
    prompt = ": ",
  },
  popup = {
    position = {
      row = "10%",
      col = "50%",
    },
    size = {
      width = "60%",
    },
    border = {
      style = "rounded",
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
  },
  hooks = {
    after_mount = function(input)
      vim.b.minicompletion_disable = true
      vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { buffer = input.bufnr })
      vim.keymap.set("i", "<c-w>", "<backspace>", { buffer = input.bufnr })
      vim.keymap.set("n", "<c-w>", "<nop>", { buffer = input.bufnr })
    end,
  },
}

vim.keymap.set("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
