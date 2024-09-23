require('mini.fuzzy').setup{}

require('mini.pick').setup{}

vim.keymap.set('n', '<c-f>', ':Pick files<cr>')
vim.keymap.set('n', '<c-s>', ':Pick live_grep<cr>')
