MiniDeps.add({
    source = 'MeanderingProgrammer/render-markdown.nvim',
    depends = { 'nvim-treesitter' },
})

require('mini.icons').setup()
require('render-markdown').setup({})
