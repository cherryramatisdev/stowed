local lspconfig = require "lspconfig"

require("inlay-hints").setup {
  only_current_line = true,
  eol = {
    right_align = true,
  },
}

-- Setup neovim lua configuration
require("neodev").setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

local rt = require "rust-tools"
rt.setup {
  server = {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

rt.inlay_hints.enable()

lspconfig.tsserver.setup {
  capabilities = capabilities,
  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
}

lspconfig.rnix.setup {
  capabilities = capabilities,
}

lspconfig.solargraph.setup {
  capabilities = capabilities,
}

lspconfig.elixirls.setup {
  capabilities = capabilities,
  settings = {
    ["elixir-ls"] = {
      dialyzerEnabled = true,
      fetchDeps = true,
      enableTestLenses = true,
      suggestSpecs = true,
    },
  },
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = {
        enable = true,
      },
    },
  },
}

-- Turn on lsp status information
require("fidget").setup()
