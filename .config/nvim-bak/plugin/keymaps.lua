-- set chdir while navigating through terminal emulator
vim.keymap.set("t", "<C-a>", [[pwd|pbcopy<CR><C-\><C-n>:cd <C-r>+<CR>iexit<cr>]])

-- next greatest remap ever
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set("n", "<D-v>", [["+p]])

-- Navigate through tabs
vim.keymap.set("n", "<Tab>", "gt")
vim.keymap.set("n", "<S-Tab>", "gT")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

for _, v in pairs { "h", "j", "k", "l" } do
  vim.keymap.set("t", "<C-w>" .. v, [[<C-\><C-n><C-w>]] .. v)
end

-- Setup codeium
vim.keymap.set("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })
vim.keymap.set("i", "<c-w>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true })
vim.keymap.set("i", "<c-q>", function()
  return vim.fn["codeium#CycleCompletions"]( -1)
end, { expr = true })
vim.keymap.set("i", "<c-;>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true })
