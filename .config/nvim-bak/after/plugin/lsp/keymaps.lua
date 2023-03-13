vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = 'Show Diagnostics on float window' })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = 'Show Diagnostics on Quickfix' })
vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
vim.keymap.set(
  "n",
  "<leader>ws",
  require("telescope.builtin").lsp_dynamic_workspace_symbols,
  { desc = "Workspace Symbols" }
)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    local map = function(keys, func, desc, type)
      if not type then
        type = "n"
      end

      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set(type, keys, func, { buffer = bufnr, desc = desc })
    end

    map("rn", vim.lsp.buf.rename, "Rename symbol with lsp")
    map("ga", vim.lsp.buf.code_action, "show code actions")
    map("ga", vim.lsp.buf.code_action, "show code actions", "x")

    map("gr", require("telescope.builtin").lsp_references, "Goto References")
    map("gI", vim.lsp.buf.implementation, "Goto implementation")
    map("<leader>T", vim.lsp.buf.type_definition, "Type Definition")

    -- See `:help K` for why this keymap
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<C-s>", vim.lsp.buf.signature_help, "Signature Documentation", "i")

    -- Lesser used LSP functionality
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")

    map("<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, "Format")
  end,
})
