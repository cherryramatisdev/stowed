---@diagnostic disable: undefined-global
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if vim.snippet.active { direction = 1 } then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  else
    return "<c-k>"
  end
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if vim.snippet.active { direction = 1 } then
    return "<Cmd>lua vim.snippet.jump(-1)<CR>"
  else
    return "<c-j>"
  end
end, { expr = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function(args)
    vim.lsp.start {
      name = "typescript-language-server",
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = vim.fs.root(args.buf, { "package.json" }),
    }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  callback = function(args)
    vim.lsp.start {
      name = "lua-language-server",
      cmd = { "lua-language-server" },
      root_dir = vim.fs.root(args.buf, { "init.lua" }),
    }
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method "textDocument/implementation" then
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = client.buf })
    end

    if client.supports_method "textDocument/completion" then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})
