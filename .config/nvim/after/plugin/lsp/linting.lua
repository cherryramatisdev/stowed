local null_ls = require "null-ls"

null_ls.setup {
  sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.credo,
    null_ls.builtins.formatting.mix,
    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.stylua,
  },
}

require("mason-null-ls").setup {
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = false,
}
