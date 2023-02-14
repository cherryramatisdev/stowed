-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Splits in a logical way
vim.o.splitbelow = true
vim.o.splitright = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set termguicolors
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- One statusline to rule them all
vim.o.laststatus = 3

-- next greatest remap ever
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Navigate through tabs
vim.keymap.set("n", "<Tab>", "gt")
vim.keymap.set("n", "<S-Tab>", "gT")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})
